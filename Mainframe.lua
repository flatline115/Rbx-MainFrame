local module = {}
	module.AddPageToTable = function(pages, tab)
		for _, page in next, pages:GetCurrentPage() do
			table.insert(tab, page);
		end;
		return tab;
	end;

	module.findPlayer = function(userId, groupId)
		local clan_service = game:GetService("GroupService");
		local allies = clan_service:GetAlliesAsync(groupId);
		local enemies = clan_service:GetEnemiesAsync(groupId);
		local userList = clan_service:GetGroupsAsync(userId);
		local status = 0; -- 0: Neutral, 1: In Clan 2: Allied 3: Enemies 4: Allied and Enemy.
		
		local clan_elements = {}
		clan_elements.enemies = {};
		clan_elements.allies = {};
		
		table.insert(clan_elements.enemies, module.AddPageToTable(enemies));
		table.insert(clan_elements.allies, module.AddPageToTable(allies));
		
		for key, info in next, userList do
			if info.Id == groupId then status = 1 break end;
				for key2, array in next, clan_elements.enemies do
					if info.Id == array.Id then
						if status == 2 then
							status = 4;
						else
							status = 3;
						end;
					end;
				end;
				
				for key3, array in next, clan_elements.allies do
					if info.Id == array.Id then
						if status == 3 then
							status = 4;
						else
							status = 2;
						end;
					end;
				end;
			end;
		
		return status;
	end;
	
	
return module
