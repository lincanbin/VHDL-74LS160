library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 
 
entity ls160 is 
port(
	data: in std_logic_vector(3 downto 0);--4λԤ������load�Ǹߵ�ƽ����
	clk,load,enp,ent,clr:in std_logic;--ע�ͼ�architecture
	count: buffer std_logic_vector(3 downto 0);--4λ����ֵ��ʹ��buffer���䱣��״̬
	tc:out std_logic--���λ���ߵ�ƽ���
);
end ls160; 
 
architecture behavior of ls160 is 
begin   
	tc<='1' when (count="1001" and enp='1' and ent='1' and load='1' and clr='1') else '0';--�����λ 
	process(clk,clr,enp,ent,load) begin 
			if(rising_edge(clk)) then --ʱ��������ʱ��ʼ����
				if(clr='1')then --CLR�ߵ�ƽ�������͵�ƽ����
					if(load='1')then --load�Ǹߵ�ƽ����
						if(enp='1')then --EnableP��PTͬʱ�Ǹߵ�ƽ����״̬
							 if(ent='1')then --EnableT�����أ�PTͬʱ�Ǹߵ�ƽ����״̬
								if(count="1001")then --CountΪ9���������
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
	end process;
end behavior;

--https://github.com/lincanbin
--20150427