import magic

with open("datadump2.txt", "rb") as f:
    file_type = magic.Magic(mime=True).from_buffer(f.read(1024))
print("tipo de encriptacion detectado: \n", file_type)