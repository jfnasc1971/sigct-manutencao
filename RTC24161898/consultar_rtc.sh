#!/bin/bash
curl -s -ki --globoff -H "Cookie: LtpaToken2=$(cat LtpaToken2.txt)" "https://gid.caixa:9443/ccm/rpt/repository/workitem?fields=workitem/workItem[id=$1]/(id|type/name|parent/(id|type/name|parent/(id|type/name|children[type/id=avalia%C3%A7%C3%A3o_bef_do_ativo]/(id|type/name|state/name|type/id))))"
#curl -s -ki --globoff -H "Cookie: LtpaToken2=$(cat LtpaToken2.txt)" "https://gid.caixa:9443/ccm/rpt/repository/workitem?fields=workitem/workItem[id=$1]/(id|parent/(parent/(children[type/id=avalia%C3%A7%C3%A3o_bef_do_ativo]/(id|state/name|type/id))))"
