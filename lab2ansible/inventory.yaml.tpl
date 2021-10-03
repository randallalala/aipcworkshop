all:
  vars:
    ansible_user: root
    ansible_ssh_private_key_file: ../aipc/keys
    ansible_connection: ssh

  # hosts:
  #   myserver:
  #     ansible_host: xx.xx.xx.xx
 
  hosts:
    %{ for d in droplets }
    ${ d.name }:
      ansible_host: ${d.ipv4_address}
    %{ endfor }