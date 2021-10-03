%{ for d in droplets }
ssh-keyscan -H ${d.ipv4_address} >> ~/.ssh/known_hosts
%{ endfor }