MmrAdjustor = {};
MmrAdjustor.fully_loaded = false;
MmrAdjustor.default_options = {

	-- main frame position
	frameRef = "CENTER",
	frameX = 0,
	frameY = 0,
	hide = false,

	-- sizing
	frameW = 200,
	frameH = 200,
};


function MmrAdjustor.OnReady()

	-- set up default options
	_G.MmrAdjustorPrefs = _G.MmrAdjustorPrefs or {};

	for k,v in pairs(MmrAdjustor.default_options) do
		if (not _G.MmrAdjustorPrefs[k]) then
			_G.MmrAdjustorPrefs[k] = v;
		end
	end

	MmrAdjustor.CreateUIFrame();
end

function MmrAdjustor.OnSaving()

	if (MmrAdjustor.UIFrame) then
		local point, relativeTo, relativePoint, xOfs, yOfs = MmrAdjustor.UIFrame:GetPoint()
		_G.MmrAdjustorPrefs.frameRef = relativePoint;
		_G.MmrAdjustorPrefs.frameX = xOfs;
		_G.MmrAdjustorPrefs.frameY = yOfs;
	end
end

function MmrAdjustor.OnUpdate()
	if (not MmrAdjustor.fully_loaded) then
		return;
	end

	if (MmrAdjustorPrefs.hide) then 
		return;
	end

	MmrAdjustor.UpdateFrame();
end

function MmrAdjustor.OnEvent(frame, event, ...)

	if (event == 'ADDON_LOADED') then
		local name = ...;
		if name == 'MmrAdjustor' then
			MmrAdjustor.OnReady();
		end
		return;
	end

	if (event == 'PLAYER_LOGIN') then

		MmrAdjustor.fully_loaded = true;
		return;
	end

	if (event == 'PLAYER_LOGOUT') then
		MmrAdjustor.OnSaving();
		return;
	end
end

function MmrAdjustor.CreateUIFrame()

	-- create the UI frame
	MmrAdjustor.UIFrame = CreateFrame("Frame",nil,UIParent);
	MmrAdjustor.UIFrame:SetFrameStrata("BACKGROUND")
	MmrAdjustor.UIFrame:SetWidth(_G.MmrAdjustorPrefs.frameW);
	MmrAdjustor.UIFrame:SetHeight(_G.MmrAdjustorPrefs.frameH);

	-- make it black
	MmrAdjustor.UIFrame.texture = MmrAdjustor.UIFrame:CreateTexture();
	MmrAdjustor.UIFrame.texture:SetAllPoints(MmrAdjustor.UIFrame);
	MmrAdjustor.UIFrame.texture:SetTexture(0, 0, 0);

	-- position it
	MmrAdjustor.UIFrame:SetPoint(_G.MmrAdjustorPrefs.frameRef, _G.MmrAdjustorPrefs.frameX, _G.MmrAdjustorPrefs.frameY);

	-- make it draggable
	MmrAdjustor.UIFrame:SetMovable(true);
	MmrAdjustor.UIFrame:EnableMouse(true);

	-- create a button that covers the entire addon
	MmrAdjustor.Cover = CreateFrame("Button", nil, MmrAdjustor.UIFrame);
	MmrAdjustor.Cover:SetFrameLevel(128);
	MmrAdjustor.Cover:SetPoint("TOPLEFT", 0, 0);
	MmrAdjustor.Cover:SetWidth(_G.MmrAdjustorPrefs.frameW);
	MmrAdjustor.Cover:SetHeight(_G.MmrAdjustorPrefs.frameH);
	MmrAdjustor.Cover:EnableMouse(true);
	MmrAdjustor.Cover:RegisterForClicks("AnyUp");
	MmrAdjustor.Cover:RegisterForDrag("LeftButton");
	MmrAdjustor.Cover:SetScript("OnDragStart", MmrAdjustor.OnDragStart);
	MmrAdjustor.Cover:SetScript("OnDragStop", MmrAdjustor.OnDragStop);
	MmrAdjustor.Cover:SetScript("OnClick", MmrAdjustor.OnClick);

	-- add a main label - just so we can show something
	MmrAdjustor.Label = MmrAdjustor.Cover:CreateFontString(nil, "OVERLAY");
	MmrAdjustor.Label:SetPoint("CENTER", MmrAdjustor.UIFrame, "CENTER", 2, 0);
	MmrAdjustor.Label:SetJustifyH("LEFT");
	MmrAdjustor.Label:SetFont([[Fonts\FRIZQT__.TTF]], 12, "OUTLINE");
	MmrAdjustor.Label:SetText(" ");
	MmrAdjustor.Label:SetTextColor(1,1,1,1);
	MmrAdjustor.SetFontSize(MmrAdjustor.Label, 20);
end

function MmrAdjustor.SetFontSize(string, size)

	local Font, Height, Flags = string:GetFont()
	if (not (Height == size)) then
		string:SetFont(Font, size, Flags)
	end
end

function MmrAdjustor.OnDragStart(frame)
	MmrAdjustor.UIFrame:StartMoving();
	MmrAdjustor.UIFrame.isMoving = true;
	GameTooltip:Hide()
end

function MmrAdjustor.OnDragStop(frame)
	MmrAdjustor.UIFrame:StopMovingOrSizing();
	MmrAdjustor.UIFrame.isMoving = false;
end

function MmrAdjustor.OnClick(self, aButton)
	if (aButton == "RightButton") then
		print("show menu here!");
	end
end

function MmrAdjustor.UpdateFrame()

	-- update the main frame state here
	MmrAdjustor.Label:SetText(string.format("%d", GetTime()));
end


MmrAdjustor.EventFrame = CreateFrame("Frame");
MmrAdjustor.EventFrame:Show();
MmrAdjustor.EventFrame:SetScript("OnEvent", MmrAdjustor.OnEvent);
MmrAdjustor.EventFrame:SetScript("OnUpdate", MmrAdjustor.OnUpdate);
MmrAdjustor.EventFrame:RegisterEvent("ADDON_LOADED");
MmrAdjustor.EventFrame:RegisterEvent("PLAYER_LOGIN");
MmrAdjustor.EventFrame:RegisterEvent("PLAYER_LOGOUT");