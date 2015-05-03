LIBRARY ieee;
USE ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 
 
ENTITY ls160 is 
PORT(
	data: in std_logic_vector(3 downto 0);--4λԤ������load�Ǹߵ�ƽ����
	clk,load,enp,ent,clr:in std_logic;--ע�ͼ�architecture
	q: buffer std_logic_vector(3 downto 0);--4λ����ֵ��ʹ��buffer���䱣��״̬
	rco:out std_logic--���λ���ߵ�ƽ���
);
END ls160; 
 
architecture behavior OF ls160 IS 
BEGIN   
	rco<='1' when (q="1001" and enp='1' and ent='1' and load='1' and clr='1') else '0';--�����λ 
	process(clk,clr,enp,ent,load) begin 
			if(rising_edge(clk)) then --ʱ��������ʱ��ʼ����
				if(clr='1')then --CLR�ߵ�ƽ�������͵�ƽ����
					if(load='1')then --load�Ǹߵ�ƽ����
						if(enp='1')then --EnableP��PTͬʱ�Ǹߵ�ƽ����״̬
							 if(ent='1')then --EnableT�����أ�PTͬʱ�Ǹߵ�ƽ����״̬
								if(q="1001")then --CountΪ9���������
									q<="0000"; 
								else  
									q<=q+1; 
								end if; 
							else
								q<=q;
							end if; 
						else
							q<=q;
						end if; 
					else
						q<=data;
					end if;
				else
					q<="0000";
				end if;
			end if;
	end process;
END behavior;

--�ֲӱ�
--https://github.com/lincanbin
--20150427