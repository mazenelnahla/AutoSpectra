import socket
import spotipy
from spotipy.oauth2 import SpotifyOAuth

# Spotify authentication
client_id = '3fb73f276ec048b78eff8151cee5563c'
client_secret = 'e8d229b5cc704e4d9c29bbd62957f93d'
redirect_uri = 'http://localhost:8888'
scope = "user-read-currently-playing"

sp = spotipy.SpotifyOAuth(client_id=client_id,
                          client_secret=client_secret,
                          redirect_uri=redirect_uri,
                          scope=scope)

token_dict = sp.get_access_token()
token = token_dict['access_token']

spotify_object = spotipy.Spotify(auth=token)

# UDP server address and port
udp_host = '127.0.0.1'  # Change to your UDP server's address
udp_port = 12345        # Change to your UDP server's port number

# Function to update the currently playing track information
def update_current_track():
    current_track = spotify_object.current_user_playing_track()
    try:
        if current_track is not None:
            track_name = current_track['item']['name']
            artist_name = current_track['item']['artists'][0]['name']
            album_name = current_track['item']['album']['name']
            album_image_url = current_track['item']['album']['images'][0]['url']
            song=track_name +"|" + artist_name + "|" + album_name + "|" + album_image_url
            print("\n" +track_name +"\n" + artist_name + "\n" + album_name + "\n" + album_image_url)
            # Send image data over UDP
            send_image_data(song)
        else:
            print("No track currently playing")
    except:
            track_name = "Advertisement"
            artist_name = "Spotify"
            album_image_url = "images/s.png"
            song=track_name +"|" + artist_name + "|" + "hello" + "|" + album_image_url
            # Send image data over UDP
            send_image_data(song)
# Function to send image data over UDP
def send_image_data(song):
    # Create a UDP socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.sendto(song.encode(), (udp_host, udp_port))
    # Close the socket
    sock.close()

# Start updating the currently playing track information
while True:
    update_current_track()

