#!/bin/bash
#################################
#         main domain           #
#################################
export main_domain="your.domain.com"                              # Change this to the correct value
export main_domain_crt="\/path\/to\/main\/domain\/fullchain.pem"  # Change this to the correct value
export main_domain_key="\/path\/to\/main\/domain\/privkey.pem"    # Change this to the correct value

#################################
#       behind cdn domain       #
#################################
export cdn_domain=""                                             # Change this to the correct value
export cdn_domain_crt="\/path\/to\/cdn\/domain\/fullchain.pem"   # Change this to the correct value
export cdn_domain_key="\/path\/to\/cdn\/domain\/privkey.pem"     # Change this to the correct value

#################################
#          uuid/pass            #
#################################
export myid=`xray uuid`                           # (optional) Let xray pick a random uuid or change it
export mypass=`date | md5sum | cut -c -15`        # (optional) Set a password or let script pick one at random


#######################################################################################
#######################################################################################
###### Do not change anything below this line unless you know what you're doing. ######
#######################################################################################
#######################################################################################

#################################
#         fake data             #
#################################
export fake_domain="example.com"
export fake_cdn_domain="behindcdn.com"
export fakepass="desdemona99"
export fakeid="90e4903e-66a4-45f7-abda-fd5d5ed7f797"
export fake_domain_crt_path="\/etc\/ssl\/example.com\/domain.pem"
export fake_domain_key_path="\/etc\/ssl\/example.com\/domain-key.pem"
export fake_cdn_domain_crt_path="\/etc\/ssl\/behindcdn.com\/domain.pem"
export fake_cdn_domain_key_path="\/etc\/ssl\/behindcdn.com\/domain-key.pem"

Help()
{
    echo "*************************************************************************"
    echo "*************************************************************************"
    echo "Please read the contents of this file and change all the required fields."
    echo "*************************************************************************"
    echo "*************************************************************************"
    echo
    echo
    echo "Commands"
    echo
    echo "m     Make and store the configs in result.txt."
    echo "r     Revert all the changes."
    echo "q     Print the qr codes of configs in terminal. Run this after running with -m."
    echo "b     Print one base64 link for all configs in terminal.  Run this after running with -m."
    echo
    echo
    echo "Usage: "
    echo
    echo "           bash setup.sh <-command> "
    echo
}

Revert()
{
    git restore client.configs/* server.jsonc nginx.conf
}

Make()
{
    #################################
    #         main domain           #
    #################################
    sed -i "s/$fake_domain_crt_path/$main_domain_crt/g" server.jsonc client.configs/* nginx.conf
    sed -i "s/$fake_domain_key_path/$main_domain_key/g" server.jsonc client.configs/* nginx.conf
    sed -i "s/$fake_domain/$main_domain/g" server.jsonc client.configs/* nginx.conf

    #################################
    #       behind cdn domain       #
    #################################
    if [ "$cdn_domain" == "" ]; then
        echo "No domain behind cdn set. Removing related fields."
        sed -i "146 s/.$//" server.jsonc
        sed -i "147,152d" server.jsonc
    fi

    sed -i "s/$fake_cdn_domain_crt_path/$cdn_domain_crt/g" server.jsonc client.configs/* nginx.conf
    sed -i "s/$fake_cdn_domain_key_path/$cdn_domain_key/g" server.jsonc client.configs/* nginx.conf
    sed -i "s/$fake_cdn_domain/$cdn_domain/g" server.jsonc client.configs/* nginx.conf

    #################################
    #          uuid/pass            #
    #################################
    sed -i "s/$fakeid/$myid/g" server.jsonc client.configs/* nginx.conf
    sed -i "s/$fakepass/$mypass/g" server.jsonc client.configs/* nginx.conf

    #################################
    #           configs             #
    #################################
    rm result.txt
    touch result.txt
    #grep "| Trojan-TCP |"  README.md | cut -f2 -d"\`" | sed "s/$fake_domain/$main_domain/g" | sed "s/$fakepass/$mypass/g" >> result.txt
    grep "| Trojan-WS |"   README.md | cut -f2 -d"\`" | sed "s/$fake_domain/$main_domain/g" | sed "s/$fakepass/$mypass/g" >> result.txt
    grep "| Trojan-gRPC |" README.md | cut -f2 -d"\`" | sed "s/$fake_domain/$main_domain/g" | sed "s/$fakepass/$mypass/g" >> result.txt
    #grep "| Trojan-H2 |"   README.md | cut -f2 -d"\`" | sed "s/$fake_domain/$main_domain/g" | sed "s/$fakepass/$mypass/g" >> result.txt
    #grep "| Vless-TCP |"   README.md | cut -f2 -d"\`" | sed "s/$fake_domain/$main_domain/g" | sed "s/$fakeid/$myid/g" >> result.txt
    grep "| Vless-WS |"    README.md | cut -f2 -d"\`" | sed "s/$fake_domain/$main_domain/g" | sed "s/$fakeid/$myid/g" >> result.txt
    grep "| Vless-gRPC |"  README.md | cut -f2 -d"\`" | sed "s/$fake_domain/$main_domain/g" | sed "s/$fakeid/$myid/g" >> result.txt
    #grep "| Vless-H2 |"    README.md | cut -f2 -d"\`" | sed "s/$fake_domain/$main_domain/g" | sed "s/$fakeid/$myid/g" >> result.txt
    #grep "| VMESS-TCP |"   README.md | cut -f2 -d"\`" | cut -c 9- | base64 -d | sed "s/$fake_domain/$main_domain/g" | sed "s/$fakeid/$myid/g" | base64 -w 0 | sed "s/^/vmess:\/\//" >> result.txt
    grep "| VMESS-WS |"    README.md | cut -f2 -d"\`" | cut -c 9- | base64 -d | sed "s/$fake_domain/$main_domain/g" | sed "s/$fakeid/$myid/g" | base64 -w 0 | sed "s/^/\nvmess:\/\//" >> result.txt
    grep "| VMESS-gRPC |"  README.md | cut -f2 -d"\`" | cut -c 9- | base64 -d | sed "s/$fake_domain/$main_domain/g" | sed "s/$fakeid/$myid/g" | base64 -w 0 | sed "s/^/\nvmess:\/\//" >> result.txt
    #grep "| VMESS-H2 |"    README.md | cut -f2 -d"\`" | cut -c 9- | base64 -d | sed "s/$fake_domain/$main_domain/g" | sed "s/$fakeid/$myid/g" | base64 -w 0 | sed "s/^/\nvmess:\/\//" >> result.txt
    echo >> result.txt

}

Print64()
{
    cat result.txt | base64 -w 0
    echo
}

Printqr()
{
    while read line; do
        export t=`echo $line | cut -c -2`
        if [ "$t" == "vm" ]; then
            echo $line | cut -c 9- | base64 -d | grep "\"ps\":" | sed -n -e 's/"ps": "//p' | sed -n -e 's/",//p' | sed -n -e 's/ *//p'
            curl qrcode.show -d $line
        else
            echo $line | sed -n -e 's/^.*#//p'
            curl qrcode.show -d $line
        fi
    done < result.txt
}

while getopts "mrqb" option; do
    case $option in
        r)
            Revert
            exit;;
        m)
            Make
            exit;;
        b)
            Print64
            exit;;
        q)
            Printqr
            exit;;

        \?)
            Help
            exit;;
    esac
done

Help

