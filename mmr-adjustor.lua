MA = {};
MA.fully_loaded = false;
MA.default_options = {

	-- main frame position
	frameRef = "CENTER",
	frameX = 0,
	frameY = 0,
	hide = false,

	-- sizing
	frameW = 200,
	frameH = 200,
};

-- BasicFrameTemplateWithInset found in BlizzardInterfaceCode/Interface/FrameXML/UIPanelTemplates.xml
-- See this guide for obtaining the BlizzardInterfaceCode: https://www.youtube.com/watch?v=0Z3b0SJuvI0
local UiConfig = CreateFrame("Frame", "MA_BuffFrame", UIParent, "BasicFrameTemplateWithInset");
--[[
	1. The type of frame - "Frame"
	2. The global frame name - "MA_BuffFrame"
	3. The Parent frame (NOT a string)
	4. Tells lua interpreter which XML template to inherit from.
		- Stored in BlizzardInterfaceCode/Interface/FrameXML/UIPanelTemplates.xml (swap this out and view in game to see which template to use)
		- You can use multiple templates comma separated: "BasicFrameTemplateWithInset, Template2, Template3"
			- As long as there's no conflicts between them of course
]]

-- Sets size of frame and puts it in center of screen
UiConfig:SetSize(300, 360);                      -- width, height
UiConfig:SetPoint("CENTER", UIParent, "CENTER"); -- point, relativeFrame, relativePoint, xOffset (int), yOffset (int)

-- Note: You can do things in Lua or XML!
-- See this guide for details on XML scripts and templates (and the below code): https://www.youtube.com/watch?v=2G4iKA1m0FA
-- UiConfig is a Lua Widget, which also makes it a table. So "title" is a key being added to the table.
-- This is a method that keeps all related data together in a table, instead of creating a separate local variable
UiConfig.title = UiConfig:CreateFontString(nil, "OVERLAY");
UiConfig.title:SetFontObject("GameFontHighlight"); -- This is a preset font type in WoW
--TitleBg is the relative frame for positioning. This key is inherited from BasicFrameTemplateWithInset. TitleBg is a texture (and therefore a frame)
UiConfig.title:SetPoint("LEFT", UiConfig.TitleBg, "LEFT", 5, 0); 
UiConfig.title:SetText("This is the title text of your Frame");






-- function MA.OnReady()

-- 	-- set up default options
-- 	_G.MAPrefs = _G.MAPrefs or {};

-- 	for k,v in pairs(MA.default_options) do
-- 		if (not _G.MAPrefs[k]) then
-- 			_G.MAPrefs[k] = v;
-- 		end
-- 	end

-- 	MA.CreateUIFrame();
-- end

-- function MA.OnSaving()

-- 	if (MA.UIFrame) then
-- 		local point, relativeTo, relativePoint, xOfs, yOfs = MA.UIFrame:GetPoint()
-- 		_G.MAPrefs.frameRef = relativePoint;
-- 		_G.MAPrefs.frameX = xOfs;
-- 		_G.MAPrefs.frameY = yOfs;
-- 	end
-- end

-- function MA.OnUpdate()
-- 	if (not MA.fully_loaded) then
-- 		return;
-- 	end

-- 	if (MAPrefs.hide) then
-- 		return;
-- 	end

-- 	MA.UpdateFrame();
-- end

-- function MA.OnEvent(frame, event, ...)

-- 	if (event == 'ADDON_LOADED') then
-- 		local name = ...;
-- 		if name == 'MA' then
-- 			MA.OnReady();
-- 		end
-- 		return;
-- 	end

-- 	if (event == 'PLAYER_LOGIN') then

-- 		MA.fully_loaded = true;
-- 		return;
-- 	end

-- 	if (event == 'PLAYER_LOGOUT') then
-- 		MA.OnSaving();
-- 		return;
-- 	end
-- end

-- function MA.CreateUIFrame()

-- 	-- create the UI frame
-- 	MA.UIFrame = CreateFrame("Frame",nil,UIParent);
-- 	MA.UIFrame:SetFrameStrata("BACKGROUND")
-- 	MA.UIFrame:SetWidth(_G.MAPrefs.frameW);
-- 	MA.UIFrame:SetHeight(_G.MAPrefs.frameH);

-- 	-- make it black
-- 	MA.UIFrame.texture = MA.UIFrame:CreateTexture();
-- 	MA.UIFrame.texture:SetAllPoints(MA.UIFrame);
-- 	MA.UIFrame.texture:SetTexture(0, 0, 0);

-- 	-- position it
-- 	MA.UIFrame:SetPoint(_G.MAPrefs.frameRef, _G.MAPrefs.frameX, _G.MAPrefs.frameY);

-- 	-- make it draggable
-- 	MA.UIFrame:SetMovable(true);
-- 	MA.UIFrame:EnableMouse(true);

-- 	-- create a button that covers the entire addon
-- 	MA.Cover = CreateFrame("Button", nil, MA.UIFrame);
-- 	MA.Cover:SetFrameLevel(128);
-- 	MA.Cover:SetPoint("TOPLEFT", 0, 0);
-- 	MA.Cover:SetWidth(_G.MAPrefs.frameW);
-- 	MA.Cover:SetHeight(_G.MAPrefs.frameH);
-- 	MA.Cover:EnableMouse(true);
-- 	MA.Cover:RegisterForClicks("AnyUp");
-- 	MA.Cover:RegisterForDrag("LeftButton");
-- 	MA.Cover:SetScript("OnDragStart", MA.OnDragStart);
-- 	MA.Cover:SetScript("OnDragStop", MA.OnDragStop);
-- 	MA.Cover:SetScript("OnClick", MA.OnClick);

-- 	-- add a main label - just so we can show something
-- 	MA.Label = MA.Cover:CreateFontString(nil, "OVERLAY");
-- 	MA.Label:SetPoint("CENTER", MA.UIFrame, "CENTER", 2, 0);
-- 	MA.Label:SetJustifyH("LEFT");
-- 	MA.Label:SetFont([[Fonts\FRIZQT__.TTF]], 12, "OUTLINE");
-- 	MA.Label:SetText(" ");
-- 	MA.Label:SetTextColor(1,1,1,1);
-- 	MA.SetFontSize(MA.Label, 20);
-- end

-- function MA.SetFontSize(string, size)

-- 	local Font, Height, Flags = string:GetFont()
-- 	if (not (Height == size)) then
-- 		string:SetFont(Font, size, Flags)
-- 	end
-- end

-- function MA.OnDragStart(frame)
-- 	MA.UIFrame:StartMoving();
-- 	MA.UIFrame.isMoving = true;
-- 	GameTooltip:Hide()
-- end

-- function MA.OnDragStop(frame)
-- 	MA.UIFrame:StopMovingOrSizing();
-- 	MA.UIFrame.isMoving = false;
-- end

-- function MA.OnClick(self, aButton)
-- 	if (aButton == "RightButton") then
-- 		print("show menu here!");
-- 	end
-- end

-- function MA.UpdateFrame()

-- 	-- update the main frame state here
-- 	MA.Label:SetText(string.format("%d", GetTime()));
-- end


-- MA.EventFrame = CreateFrame("Frame");
-- MA.EventFrame:Show();
-- MA.EventFrame:SetScript("OnEvent", MA.OnEvent);
-- MA.EventFrame:SetScript("OnUpdate", MA.OnUpdate);
-- MA.EventFrame:RegisterEvent("ADDON_LOADED");
-- MA.EventFrame:RegisterEvent("PLAYER_LOGIN");
-- MA.EventFrame:RegisterEvent("PLAYER_LOGOUT");
