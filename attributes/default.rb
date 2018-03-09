default['es_wrapper']['jvm_memory'] = (node['memory']['total'].to_i / 2 / 1024)
default['es_wrapper']['hosts'] = ["192.168.0.10", "192.168.0.11", "192.168.0.12"]
