LIBRARY ieee;
USE ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 
 
ENTITY ls160 is 
PORT(
	data: in std_logic_vector(3 downto 0); 
	clk,load,enp,ent,clr:in std_logic; 
	count: buffer std_logic_vector(3 downto 0); 
	tc:out std_logic 
);
END ls160; 
 
architecture behavior OF ls160 IS 
BEGIN   
	tc<='1' when (count="1001" and enp='1' and ent='1' and load='1' and clr='1') else '0';--溢出进位 
	cale:
		process(clk,clr,enp,ent,load) 
		begin 
			if(rising_edge(clk)) then --时钟上升沿时开始工作
				if(clr='1')then --CLR高电平工作，低电平清零
					if(load='1')then --load非高电平置数
						if(enp='1')then --EnableP，PT同时非高电平保存状态
							 if(ent='1')then --EnableT，开关，PT同时非高电平保存状态
								if(count="1001")then --Count为9，溢出重置
									count<="0000"; 
								else  
									count<=count+1; 
								end if; 
							else
								count<=count;
							end if; 
						else
							count<=count;
						end if; 
					else 
						count<=data;
					end if;
				else
					count<="0000";
				end if;
			end if;
	end process cale;
END behavior;

--https://github.com/lincanbin
--20150427