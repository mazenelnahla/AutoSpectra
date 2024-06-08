import socket
import spotipy
import json
import time
import logging
from spotipy.oauth2 import SpotifyOAuth

# UDP server address and port
udp_host = '127.0.0.1'  # Change to your UDP server's address
udp_port = 12345        # Change to your UDP server's port number
# Setup logging
logging.basicConfig(level=logging.INFO)

# Spotify authentication
client_id = '3fb73f276ec048b78eff8151cee5563c'
client_secret = 'e8d229b5cc704e4d9c29bbd62957f93d'
redirect_uri = 'http://localhost:8888'
scope = "user-read-currently-playing"

sp_auth = SpotifyOAuth(client_id=client_id,
                       client_secret=client_secret,
                       redirect_uri=redirect_uri,
                       scope=scope)

token_info = sp_auth.get_cached_token()
if not token_info:
    token_info = sp_auth.get_access_token(as_dict=False)

token = token_info
spotify_object = spotipy.Spotify(auth=token)

# Function to update the currently playing track information
def update_current_track():
    global spotify_object, token_info, token
    if sp_auth.is_token_expired(token_info):
        token_info = sp_auth.refresh_access_token(sp_auth.cache_path)
        token = token_info
        spotify_object = spotipy.Spotify(auth=token)

    try:
        current_track = spotify_object.current_user_playing_track()
        if current_track is not None and current_track['item'] is not None:
            json_data = {
                "trackName": current_track['item']['name'],
                "artistName": current_track['item']['artists'][0]['name'],
                "albumName": current_track['item']['album']['name'],
                "albumURL": current_track['item']['album']['images'][0]['url']
            }
        else:
            json_data = {
                "trackName": "Advertisement",
                "artistName": "Spotify",
                "albumName": "",
                "albumURL": "images/s.png"
            }
        send_image_data(json_data)
    except Exception as e:
        logging.error(f"Error retrieving current track: {e}")


# Function to send image data over UDP
def send_image_data(json_data):
    try:
        # Create a UDP socket
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        json_bytes = json.dumps(json_data).encode('utf-8')
        sock.sendto(json_bytes, (udp_host, udp_port))
        logging.info(f"Sent data: {json_data}")
    except Exception as e:
        logging.error(f"Error sending data: {e}")
    finally:
        # Close the socket
        sock.close()

# Start updating the currently playing track information
while True:
    update_current_track()
    time.sleep(5)  # Wait for 5 seconds before checking again
