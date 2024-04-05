import socket

def send_tcp_packet(target_ip, target_port, data):
    # ソケットを作成し、指定したIPアドレスとポートに接続します
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.connect((target_ip, target_port))

    # データを送信します
    sock.sendall(data.encode())

    # ソケットを閉じます
    sock.close()

# 送信先のIPアドレスとポートを指定します
target_ip = '127.0.0.1'
target_port = 12345

# 送信するデータを指定します
data = 'Hello, world!'

# TCPパケットを送信します
send_tcp_packet(target_ip, target_port, data)
