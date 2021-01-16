--connection = dbConnect("mysql", "dbname=clubeclub;host=127.0.0.1;charset=utf8", "root", "", "share=1");
local connection = exports.cc_mysql:getConnection();
--[[function lvl(playerSource)
local adminlevel = 5
setElementData(playerSource, "adminlevel", adminlevel)
outputChatBox(getElementData(playerSource, "adminlevel"))
end 
addCommandHandler("lvl", lvl)--]]

function playerJoin()
	local serial = getPlayerSerial(source)
	local player = source
	setCameraMatrix(player, 1410.29224, -897.19824, 93.42935, 1413.49109, -839.67212, 85.37855)
	setElementData(player, "loggined", false)
	print("FALSE")
	dbQuery(function(handler) 
		local result = dbPoll(handler, 0)
			if (result[1].banned == 1) then 
				kickPlayer(player, "TEST1", "TEST2")
			else 
				setElementPosition(player, 1, 1, 1)
				setElementFrozen(player, true)
				triggerClientEvent(player, "paneltrigger", player)
			end 
	end, connection, "SELECT banned from account where serial=?", serial)
end
addEventHandler ( "onPlayerJoin", root, playerJoin)

function login(Username, Password)
	local player = client
	local serial = getPlayerSerial(player)
	dbQuery(function(handler) 
		local result = dbPoll(handler, 0)
			if (result and #result == 1) then 
				if passwordVerify(Password, result[1].password) then
					outputChatBox("Bejelentkeztem")
					setElementFrozen(player, false)
					spawnplayer(player)
					local loggined = true 
					setElementData(player, "loggined", loggined)
					setCameraTarget(player)
				else
					outputChatBox("Helytelen jelszó!")
				end 	
			else 
				outputChatBox("Nem létezik ilyen felhasználónév", player)
			end 
	end, connection, "SELECT username, password from account where username=?", Username)
end 
addEvent("login", true)
addEventHandler("login", root, login)

function register(Username, Password) 
	local player = client
	dbQuery(function(handler) 
		local result = dbPoll(handler, 0)
		if (result and #result == 0) then 
			local hashedPassword = passwordHash(Password,"bcrypt",{})
			local serial = getPlayerSerial(player)
			dbExec(connection, "INSERT INTO account SET username=?, password=?, serial=?", Username, hashedPassword, serial)
			outputChatBox("Sikeres regisztráció!")
		else 
			outputChatBox("Már létezik ilyen felhasználó!", player)
		end 
	end, connection, "SELECT username from account where username=?", username)
end 
addEvent("register", true)
addEventHandler("register", root, register)

function spawnplayer(player)
	local serial = getPlayerSerial(player)
	setElementData(player, "adminduty", false)
	dbQuery(function(handler) 
		local result = dbPoll(handler, 0)
		if (result) then 
			local result = result
			setElementPosition(player, result[1].x, result[1].y, result[1].z)	
			setElementRotation(player, result[1].rotx, result[1].roty, result[1].rotz)
			setElementModel(player, result[1].skin)
			setElementHealth(player, result[1].hp)
			setPedArmor(player, result[1].armour)
			setPlayerMoney(player, result[1].money)
			setElementInterior(player, result[1].interior)
			setElementDimension(player, result[1].dimension)
			setElementData(player, "adminlevel", tonumber(result[1].adminlevel))
			setElementData(player, "loggined", true)

			if ((tonumber(result[1].adminlevel)) >= 1) then 
				dbQuery(function(handler) 
					local result = dbPoll(handler, 0)
					if (result) then 
						local result = result
						setElementData(player, "admin:Fix", result[1].Fix)
						setElementData(player, "admin:Fuel", result[1].FuelVeh)
						setElementData(player, "admin:SetHp", result[1].SetHp)
						setElementData(player, "admin:SetArmor", result[1].SetArmor)
						setElementData(player, "admin:PM", result[1].PM)
						setElementData(player, "admin:VA", result[1].VA)
						setElementData(player, "admin:dutytime", result[1].dutytime)
					end 
				end, connection, "SELECT Fix, FuelVeh, SetHp, SetArmor, PM, VA, dutytime FROM adminstats WHERE serial=? LIMIT 1", serial)
			end 

		end 
	end, connection, "SELECT x, y, z, rotx, roty, rotz, interior, dimension, skin, hp, armour, money, adminlevel FROM account WHERE serial=? LIMIT 1", serial)
	triggerClientEvent(player, "removeall", player)
end 

function quit(player)
	local serial = getPlayerSerial(source)
	if (getElementData(source, "loggined")) then
		local player = source
		local x, y, z = getElementPosition(player)
		local rotx, roty, rotz = getElementRotation(player)
		local interior = getElementInterior(player)
		local dimension = getElementDimension(player)
		local skin = getElementModel(player)
		local hp = getElementHealth(player)
		local armour = getPedArmor(player)
		local money = getPlayerMoney(player)
		local adminlevel = getElementData(player, "adminlevel")
		local exec = dbExec(connection, "UPDATE account SET x=?, y=?, z=?, rotx=?, roty=?, rotz=?, interior=?, dimension=?, skin=?, hp=?, armour=?, money=?, adminlevel=? WHERE serial=?", x, y, z, rotx, roty, rotz, interior, dimension, skin, hp, armour, money, adminlevel, serial);
		if (tonumber(adminlevel) >= 1) then 
			setElementData(player, "admin:aname", getPlayerName(player))
			local qh = dbQuery(connection, "SELECT * FROM adminstats WHERE serial=?", serial);
			local res = dbPoll(qh, 500);
			if (res) then
				if (#res > 0) then
					local adminexec = dbExec(connection, "UPDATE adminstats SET Fix=?, FuelVeh=?, SetHp=?, SetArmor=?, PM=?, VA=?, dutytime=? WHERE serial=?", getElementData(player, "admin:Fix"), getElementData(player, "admin:Fuel"), getElementData(player, "admin:SetHp"), getElementData(player, "admin:SetArmor"), getElementData(player, "admin:PM"), getElementData(player, "admin:VA"), getElementData(player, "admin:dutytime"), serial);
					if (adminexec) then 
						print("exec")
					end 
				else
					dbExec(connection, "INSERT INTO adminstats SET aName=?, Serial=?, Fix=?, FuelVeh=?, SetHp=?, SetArmor=?, PM=?, VA=?", getElementData(player, "admin:aname"), serial, getElementData(player, "admin:Fix"), getElementData(player, "admin:Fuel"), getElementData(player, "admin:SetHp"), getElementData(player, "admin:SetArmor"), getElementData(player, "admin:PM"), getElementData(player, "admin:VA"), getElementData(player, "admin:dutytime"));
				end
			end
		end 
	else 
		print("ELSE")
	end 
end 
addEventHandler("onPlayerQuit", root, quit)

function sdg(player) 
	local szint = getElementData(player, "adminlevel")
	local lvl = tonumber(szint)
	outputChatBox(lvl)
end 
addCommandHandler("kiiras", sdg)
----------------------------------------

