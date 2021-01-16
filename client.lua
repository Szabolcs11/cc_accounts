local x, y = guiGetScreenSize()
Username = ""
Password = ""

RegUsername = "Felhasználónév"
RegPassword = "Jelszó"
RegPassword2 = "Jelszó 2x"
RegEmail = "E-Mail"

panelstate = 1 --1 Loginpanel, 2 Regpanel

function renderpanel()
	dxDrawRectangle(x*0.35, y*0.3, x*0.3, y*0.3, tocolor(0, 0, 0, 220)) --Panel háttér
	dxDrawRectangle(x*0.37, y*0.35, x*0.26, y*0.05, tocolor(255, 255, 255, isMouseInPosition(x*0.37, y*0.35, x*0.26, y*0.05) and 220 or 255)) -- Felső 220

	-- dxDrawRectangle(x*0.87, y*0.88, x*0.10, y*0.09, tocolor(255, 0, 64, isMouseInPosition(x*0.87, y*0.88, x*0.10, y*0.09) and 180 or 255))


	dxDrawRectangle(x*0.37, y*0.42, x*0.26, y*0.05, tocolor(255, 255, 255, isMouseInPosition(x*0.37, y*0.42, x*0.26, y*0.05) and 220 or 255)) -- Alsó

	dxDrawRectangle(x*0.37, y*0.5, x*0.1, y*0.05, tocolor(255, 255, 255, isMouseInPosition(x*0.37, y*0.5, x*0.1, y*0.05) and 220 or 255)) -- Gomb Bal oldali 
	dxDrawText("Bejelentkezés", x*0.69, y*0.51, x*0.15, y*0.05, tocolor(0, 0, 0, 255), 2, "default", "center")
	dxDrawRectangle(x*0.53, y*0.5, x*0.1, y*0.05, tocolor(255, 255, 255, isMouseInPosition(x*0.53, y*0.5, x*0.1, y*0.05) and 220 or 255)) -- Gomb Jobb oldalo
	dxDrawText("Regisztráció", x*0.96, y*0.51, x*0.2, y*0.05, tocolor(0, 0, 0, 255), 2, "default", "center")
	dxDrawText(Username, x*0.74, y*0.36, x*0.26, y*0.05, tocolor(0, 0, 0, 255), 2, "default", "center")
	dxDrawText(Password, x*0.74, y*0.43, x*0.26, y*0.05, tocolor(0, 0, 0, 255), 2, "default", "center")
end 
--addEventHandler("onClientRender", root, renderpanel)

function renderregisterpanel()
	dxDrawRectangle(x*0.35, y*0.3, x*0.3, y*0.5, tocolor(0, 0, 0, 220)) --Panel háttér

	dxDrawRectangle(x*0.37, y*0.36, x*0.26, y*0.05, tocolor(255, 255, 255, isMouseInPosition(x*0.37, y*0.35, x*0.26, y*0.05) and 220 or 255)) -- Felhasználónév 
	dxDrawText(RegUsername, x*0.5, y*0.37, x*0.5, y*0.05, tocolor(0, 0, 0, 255), 2, "default", "center")

	dxDrawRectangle(x*0.37, y*0.43, x*0.26, y*0.05, tocolor(255, 255, 255, isMouseInPosition(x*0.37, y*0.42, x*0.26, y*0.05) and 220 or 255)) -- Jelszó 
	dxDrawText(RegPassword, x*0.5, y*0.44, x*0.5, y*0.05, tocolor(0, 0, 0, 255), 2, "default", "center")

	dxDrawRectangle(x*0.37, y*0.50, x*0.26, y*0.05, tocolor(255, 255, 255, isMouseInPosition(x*0.37, y*0.49, x*0.26, y*0.05) and 220 or 255)) -- Jelszó 2x
	dxDrawText(RegPassword2, x*0.5, y*0.51, x*0.5, y*0.05, tocolor(0, 0, 0, 255), 2, "default", "center")

	dxDrawRectangle(x*0.37, y*0.57, x*0.26, y*0.05, tocolor(255, 255, 255, isMouseInPosition(x*0.37, y*0.56, x*0.26, y*0.05) and 220 or 255)) -- Email
	dxDrawText(RegEmail, x*0.5, y*0.58, x*0.5, y*0.05, tocolor(0, 0, 0, 255), 2, "default", "center")

	dxDrawRectangle(x*0.37, y*0.7, x*0.1, y*0.05, tocolor(255, 255, 255, isMouseInPosition(x*0.37, y*0.7, x*0.1, y*0.05) and 220 or 255)) -- Gomb Bal oldali 
	dxDrawText("Bejelentkezés", x*0.69, y*0.71, x*0.15, y*0.05, tocolor(0, 0, 0, 255), 2, "default", "center")
	dxDrawRectangle(x*0.53, y*0.7, x*0.1, y*0.05, tocolor(255, 255, 255, isMouseInPosition(x*0.53, y*0.7, x*0.1, y*0.05) and 220 or 255)) -- Gomb Jobb oldalo
	dxDrawText("Regisztráció", x*0.96, y*0.71, x*0.2, y*0.05, tocolor(0, 0, 0, 255), 2, "default", "center")
	dxDrawText(Username, x*0.74, y*0.36, x*0.26, y*0.05, tocolor(0, 0, 0, 255), 2, "default", "center")
	dxDrawText(Password, x*0.74, y*0.43, x*0.26, y*0.05, tocolor(0, 0, 0, 255), 2, "default", "center")
end 
-- addEventHandler("onClientRender", root, renderregisterpanel)

function paneltrigger()
	addEventHandler("onClientRender", root, renderpanel)
	addEventHandler("onClientClick", root, click)
	showChat(false)
	setPlayerHudComponentVisible("radar", false)
	panelstate = 1
end 
addEvent("paneltrigger", true)
addEventHandler("paneltrigger", root, paneltrigger)

function click(button, state)
	if (button == "left" and state == "up") then 

		if (isEventHandlerAdded("onClientRender", root, renderregisterpanel)) then

			if (isMouseInPosition(x*0.37, y*0.36, x*0.26, y*0.05)) then  --Username
				RegUsernameActive = true
				RegPassword1Active = false
				RegPassword2Active = false
				RegEmailActive = false
				outputChatBox("RegUsername")
				if (RegUsername == "Felhasználónév") then 
					RegUsername = ""
				end 
			end 
	
			if (isMouseInPosition(x*0.37, y*0.43, x*0.26, y*0.05)) then 
				RegUsernameActive = false
				RegPassword1Active = true
				RegPassword2Active = false
				RegEmailActive = false
				outputChatBox("RegPassword1")
				if (RegPassword == "Jelszó") then 
					RegPassword = ""
				end 
			end
	
			if (isMouseInPosition(x*0.37, y*0.50, x*0.26, y*0.05)) then 
				RegUsernameActive = false
				RegPassword1Active = false
				RegPassword2Active = true
				RegEmailActive = false
				outputChatBox("RegPassword2")
				if (RegPassword2 == "Jelszó 2x") then 
					RegPassword2 = ""
				end 
			end
	
			if (isMouseInPosition(x*0.37, y*0.57, x*0.26, y*0.05)) then 
				RegUsernameActive = false
				RegPassword1Active = false
				RegPassword2Active = false
				RegEmailActive = true
				outputChatBox("RegEmail")
				if (RegEmail == "E-Mail") then 
					RegEmail = ""
				end 
			end 

			if (isMouseInPosition(x*0.37, y*0.7, x*0.1, y*0.05)) then 
				removeEventHandler("onClientRender", root, renderregisterpanel)
				addEventHandler("onClientRender", root, renderpanel)
				RegUsername = ""
				RegPassword = ""
				RegPassword2 = ""
				RegEmail = ""
				RegUsernameLenght = utf8.len(RegUsername)
				RegPasswordLenght = utf8.len(RegPassword)
				RegPassword2Lenght = utf8.len(RegPassword2)
				RegEmailLenght = utf8.len(RegEmail)
			end 

			if (isMouseInPosition(x*0.53, y*0.7, x*0.1, y*0.05)) then 
				if (RegPassword == RegPassword2) then 
					if (RegUsernameLenght > 5 and RegPasswordLenght > 5 and RegPassword2Lenght > 5) then 
						triggerServerEvent("register", localPlayer, RegUsername, RegPassword)
					else 
						outputChatBox("Nem elég hosszú a felhasználónév / jelszó / email")
					end 
				else 
					outputChatBox("Nem ugyanaz a 2 jelszó!")
				end 
			end 


		else 

			if (isMouseInPosition(x*0.37, y*0.35, x*0.26, y*0.05)) then 
				PasswordActive = false
				UsernameActive = true
				outputChatBox("Username")
			end 

			if (isMouseInPosition(x*0.37, y*0.42, x*0.26, y*0.05)) then 
				UsernameActive = false
				PasswordActive = true
				outputChatBox("Password")
			end

			if (isMouseInPosition(x*0.53, y*0.5, x*0.1, y*0.05)) then 
				-- triggerServerEvent("register", localPlayer, Username, Password)
				addEventHandler("onClientRender", root, renderregisterpanel)
				removeEventHandler("onClientRender", root, renderpanel)
				UsernameActive = false
				PasswordActive = false
				Username = ""
				Usernamelength  = utf8.len(Username)
				Password = ""
				Passwordlenght  = utf8.len(Password) 
				RegEmailLenght = utf8.len(RegEmail)
			end 

			if (isMouseInPosition(x*0.37, y*0.5, x*0.1, y*0.05)) then 
				triggerServerEvent("login", localPlayer, Username, Password)
			end		
		end
	end
end 
-- addEventHandler("onClientClick", root, click)  -- Ezt vissza, nem kell az venetcucc

function character (character)
	if (isEventHandlerAdded("onClientRender", root, renderregisterpanel)) then
		if (RegUsernameActive) then 
			RegUsername = RegUsername..character
			RegUsernameLenght = utf8.len(RegUsername)
		end 

		if (RegPassword1Active) then 
			RegPassword = RegPassword..character
			RegPasswordLenght = utf8.len(RegPassword)
		end 

		if (RegPassword2Active) then 
			RegPassword2 = RegPassword2..character
			RegPassword2Lenght = utf8.len(RegPassword2)
		end 

		if (RegEmailActive) then 
			RegEmail = RegEmail..character
			RegEmailLenght = utf8.len(RegEmail)
		end 

	else 

		if (UsernameActive) then 
			Username = Username..character
			Usernamelength  = utf8.len(Username) 
		end 

		if (PasswordActive) then 
			Password = Password..character
			Passwordlenght  = utf8.len(Password) 
		end 
	end 
end 
addEventHandler("onClientCharacter", root, character)

function deletechar (button, state)
	if (button == "backspace" and state == false) then 

		if (isEventHandlerAdded("onClientRender", root, renderregisterpanel)) then

			if (RegUsernameActive) then 
				RegUsername = utf8.sub(RegUsername, 1, RegUsernameLenght -1)
				RegUsernameLenght = utf8.len(RegUsername)
			end 
		
			if (RegPassword1Active) then 
				RegPassword = utf8.sub(RegPassword, 1, RegPasswordLenght - 1)
				RegPasswordLenght = utf8.len(RegPassword)
			end 
		
			if (RegPassword2Active) then 
				RegPassword2 = utf8.sub(RegPassword2, 1, RegPassword2Lenght - 1)
				RegPassword2Lenght = utf8.len(RegPassword2)
			end 
		
			if (RegEmailActive) then 
				RegEmail = utf8.sub(RegEmail, 1, RegEmailLenght - 1)
				RegEmailLenght = utf8.len(RegEmail)
			end 

		else 

			if (UsernameActive) then 
				Username = utf8.sub(Username, 1, Usernamelength - 1)
				Usernamelength  = utf8.len(Username)
			end 

			if (PasswordActive) then 
				Password = utf8.sub(Password, 1, Passwordlenght - 1)
				Passwordlenght  = utf8.len(Password) 
			end 
		end 
	end 
end 
addEventHandler("onClientKey", root, deletechar)

function isInBox(x,y,x2,y2)
	if (isCursorShowing()) then
		local cX, cY = getCursorPosition();
		if ( (cX >= x) and (cY >= y) and (cX <= x2) and (cY <= y2) ) then
			return true;
		else
			return false;
		end
	end
end

function isMouseInPosition ( x2, y2, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * x ), ( cy * y )
	
	return ( ( cx >= x2 and cx <= x2 + width ) and ( cy >= y2 and cy <= y2 + height ) )
end

function removeall()
	removeEventHandler("onClientCharacter", root, character)
	removeEventHandler("onClientRender", root, renderpanel)
	removeEventHandler("onClientClick", root, click)
	removeEventHandler("onClientKey", root, deletechar)
	showChat(true)
	setPlayerHudComponentVisible("radar", true)
end 
addEvent("removeall", true)
addEventHandler("removeall", root, removeall)


function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end