# kbot
Telegram bot with cobra handler

To build bot make next steps

1. Clone repo ``` git clone https://github.com/IgorTkachuk/kbot.git ```;
2. Use the command ``` go get ``` for install dependencies;
3. Use the command ``` go build -ldlags "-X="github.com/IgorTkachuk/kbot/cmd.appVersion=v1.0.2 ``` with appropriate simver;
4. Make the bot by "botfater" and take the token
5. Export the token to environment
```sh
    read -s TELE_TOKEN
    echo $TELE_TOKEN
    export TELE_TOKEN
```
6. Run app with command ```./kbot go```
7. On bot dialog type "hello". The bot answer with actual version number.


[Here link on bot](https://t.me/myave_bot)