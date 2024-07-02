import socket
import spotipy
import json
from spotipy.oauth2 import SpotifyOAuth
import time

# Spotify authentication
client_id = '3fb73f276ec048b78eff8151cee5563c'
client_secret = 'e8d229b5cc704e4d9c29bbd62957f93d'
redirect_uri = 'http://localhost:8888'
scope = "user-read-currently-playing"

# UDP server address and port
udp_host = '127.0.0.1'  # Change to your UDP server's address
udp_port = 12356        # Change to your UDP server's port number

# Function to update the currently playing track information
def update_current_track():
    while True:
        try:
            sp = spotipy.SpotifyOAuth(client_id=client_id,
                                      client_secret=client_secret,
                                      redirect_uri=redirect_uri,
                                      scope=scope)
            token_dict = sp.get_access_token()
            token = token_dict['access_token']

            spotify_object = spotipy.Spotify(auth=token)
            current_track = spotify_object.current_user_playing_track()

            if current_track is not None:
                json_data = {
                    "trackName": current_track['item']['name'],
                    "artistName": current_track['item']['artists'][0]['name'],
                    "albumName": current_track['item']['album']['name'],
                    "albumURL": current_track['item']['album']['images'][0]['url']
                }
            else:
                json_data = {
                    "trackName": "",
                    "artistName": "",
                    "albumName": "",
                    "albumURL": ""
                }
            
            send_song_data(json_data)
            # Sleep for a few seconds before checking again
            time.sleep(5)

        except (socket.error, spotipy.SpotifyException) as e:
            # Handle specific exceptions (like socket errors or Spotify API errors)
            print(f"Error occurred: {str(e)}")
            # Wait before retrying
            time.sleep(10)
        except Exception as e:
            # Handle any other unexpected exceptions
            print(f"Unexpected error occurred: {str(e)}")
            # Wait before retrying
            time.sleep(10)

# Function to send image data over UDP
def send_song_data(json_data):
    try:
        # Create a UDP socket
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        json_bytes = json.dumps(json_data).encode('utf-8')
        sock.sendto(json_bytes, (udp_host, udp_port))
        # Close the socket
        sock.close()
    except socket.error as e:
        print(f"Socket error occurred while sending data: {str(e)}")

# Start updating the currently playing track information
update_current_track()
