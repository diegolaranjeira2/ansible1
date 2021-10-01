#!/bin/sh
### Descrição: Cria o arquivo de inventario com as variaveis e vms para uso pelas rotinas de update
### Autor: Renan Dias (Grilo Sueco) - renan.dsilva@totvs.com.br

### VMs Windows
cat > /root/update_rm/inventario_update_rm <<'EOF'
[prod]
EOF
cat > /root/update_rm/inventario_snapshot_rm <<'EOF'
[prod]
EOF


while read linha; do
grep $linha /opt/lista_tesp2_geral_vms_e_floatip.txt | awk '{print $2}' >> /root/update_rm/inventario_update_rm;
grep $linha /opt/lista_tesp2_geral_vms_e_floatip.txt | awk '{print $1}' >> /root/update_rm/inventario_snapshot_rm;
done < /mnt/update_windows_rm.txt

#cp /root/inventory_creator/inventario_update_rm /root/update_rm
#cp /root/inventory_creator/inventario_snapshot_rm /root/update_rm

git -C /root/update_rm pull

git -C /root/update_rm add inventario_update_rm
git -C /root/update_rm add inventario_snapshot_rm

git -C /root/update_rm commit -m "Inventario Atualizado"

git -C /root/update_rm push



