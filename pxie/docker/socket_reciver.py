import socket

def start_tcp_server(listen_ip, listen_port):
    # ソケットを作成し、指定したIPアドレスとポートで接続を待ち受けます
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind((listen_ip, listen_port))
    server_socket.listen(5)  # 最大接続数を指定します

    print(f"[*] Listening on {listen_ip}:{listen_port}")

    # 接続を受け入れ、データを受信します
    while True:
        client_socket, addr = server_socket.accept()
        print(f"[*] Accepted connection from {addr[0]}:{addr[1]}")

        data = client_socket.recv(1024).decode()
        if not data:
            break

        print(f"[*] Received data: {data}")

        # データを処理するコードを追加します

        client_socket.close()

    server_socket.close()

# デーモンとして動作させる場合は、IPアドレスを '0.0.0.0' に設定し、全てのネットワークインターフェースからの接続を受け入れるようにします
listen_ip = '0.0.0.0'
listen_port = 12345

# TCPサーバーを起動します
start_tcp_server(listen_ip, listen_port)
