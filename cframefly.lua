local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService")

local Maid = loadstring(game:HttpGet('https://raw.githubusercontent.com/Quenty/NevermoreEngine/main/src/maid/src/Shared/Maid.lua'))()

shared.Maid = shared.Maid or Maid.new(); local Maid = shared.Maid; Maid:DoCleaning();
shared.Active = true;

local Offset = 0.5;

local Camera = workspace.CurrentCamera;

local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait();
local Character = LocalPlayer.Character or LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();

local CurrentPoint = Character:GetPivot();

local wait = task.wait;

Maid:GiveTask(LocalPlayer.CharacterAdded:Connect(function(NewCharacter)
    Character = NewCharacter
end))

Maid:GiveTask(RunService.Stepped:Connect(function()
    if shared.Active then
        local CameraCFrame = Camera.CFrame
        
        CurrentPoint = CFrame.new(CurrentPoint.Position, CurrentPoint.Position + CameraCFrame.LookVector)
        Character:PivotTo(CurrentPoint);
    end
end))

local KeyBindStarted = {
    [Enum.KeyCode.Q] = {
        ["FLY_UP"] = function()
            while UserInputService:IsKeyDown(Enum.KeyCode.Q) do
                
                CurrentPoint = CurrentPoint * CFrame.new(0, Offset, 0)
                RunService.Stepped:Wait()
            end
        end;
    };
    [Enum.KeyCode.E] = {
        ["FLY_DOWN"] = function()
            while UserInputService:IsKeyDown(Enum.KeyCode.E) do
                
                CurrentPoint = CurrentPoint * CFrame.new(0, -Offset, 0)
                RunService.Stepped:Wait()
            end
        end;
    };
    [Enum.KeyCode.W] = {
        ["FLY_FORWARD"] = function()
            while UserInputService:IsKeyDown(Enum.KeyCode.W) do
                
                CurrentPoint = CurrentPoint * CFrame.new(0, 0, -Offset)
                RunService.Stepped:Wait()
            end
        end;
    };
    [Enum.KeyCode.S] = {
        ["FLY_BACK"] = function()
            while UserInputService:IsKeyDown(Enum.KeyCode.S) do
                
                CurrentPoint = CurrentPoint * CFrame.new(0, 0, Offset)
                RunService.Stepped:Wait()
            end
        end;
    };
    [Enum.KeyCode.A] = {
        ["FLY_LEFT"] = function()
            while UserInputService:IsKeyDown(Enum.KeyCode.A) do
                
                CurrentPoint = CurrentPoint * CFrame.new(-Offset, 0, 0)
                RunService.Stepped:Wait()
            end
        end;
    };
    [Enum.KeyCode.D] = {
        ["FLY_RIGHT"] = function()
            while UserInputService:IsKeyDown(Enum.KeyCode.D) do
                
                CurrentPoint = CurrentPoint * CFrame.new(Offset, 0, 0)
                RunService.Stepped:Wait()
            end
        end;
    };
    [Enum.KeyCode.Equals] = {
        ["TOGGLE"] = function()
            if not shared.Active then
                CurrentPoint = Character:GetPivot();
            end
            
            shared.Active = not shared.Active
        end;
    }
}

Maid:GiveTask(UserInputService.InputBegan:Connect(function(Input, GameProcessedEvent)
	if not GameProcessedEvent then
		if Input.UserInputType == Enum.UserInputType.Keyboard and KeyBindStarted[Input.KeyCode] then
			for _, Function in pairs(KeyBindStarted[Input.KeyCode]) do
				task.spawn(Function)
			end
		elseif KeyBindStarted[Input.UserInputType] then
			for _, Function in pairs(KeyBindStarted[Input.UserInputType]) do
                task.spawn(Function)
			end
		end
	end
end))


