#!/bin/bash

while true; do
    echo "Menu:"
    echo "[1] List Domain"
    echo "[2] Extract specific domain"
    read -p "Choose an option (1 or 2): " option

    case $option in
        1)
            grep "Host:" * 2>/dev/null | grep -v android | cut -d "/" -f 3 | sort -u > res/list_domain.txt
            echo "List of domains extracted and saved in res/list_domain.txt"
            break
            ;;
        2)
            echo "Choose a specific domain:"
            echo "[1] Netflix"
            echo "[2] Tiktok"
            echo "[3] Instagram"
            echo "[4] Facebook"
            echo "[5] Twitter"
            echo "[6] All available options"
            read -p "Enter your choice: " domain_option

            case $domain_option in
                1)
                    domain="netflix"
                    ;;
                2)
                    domain="tiktok"
                    ;;
                3)
                    domain="instagram"
                    ;;
                4)
                    domain="facebook"
                    ;;
                5)
                    domain="twitter"
                    ;;
                6)
                    domain="all"
                    ;;
                *)
                    echo "Invalid choice. Exiting."
                    exit 1
                    ;;
            esac

            if [ "$domain" == "all" ]; then
                for d in netflix tiktok instagram facebook twitter; do
                    grep -i "$d" -A 2 * 2>/dev/null | cut -d " " -f 2,3 > "res/all_${d}.txt"
                    echo "Extraction complete. Results saved in res/all_${d}.txt"
                    echo "Total line for $d: $(grep -i "$d" -A 2 * 2>/dev/null | grep Host | wc -l)"
                done
            else
                grep -i "$domain" -A 2 * 2>/dev/null | cut -d " " -f 2,3 > "res/all_${domain}.txt"
                echo "Extraction complete. Results saved in res/all_${domain}.txt"
                echo "Total line for $domain: $(grep -i "$domain" -A 2 * 2>/dev/null | grep Host | wc -l)"
            fi

            break
            ;;
        *)
            echo "Invalid choice. Please enter 1 or 2."
            ;;
    esac
done
