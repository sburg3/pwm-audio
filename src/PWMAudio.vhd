----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2015 03:07:04 PM
-- Design Name: 
-- Module Name: PWMAudio - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PWMAudio is
    Port ( CLK100MHZ : in STD_LOGIC;
           AUD_PWM : out STD_LOGIC;
           AUD_SD : out STD_LOGIC;
           SW : in STD_LOGIC_VECTOR(8 downto 0));
end PWMAudio;

architecture Behavioral of PWMAudio is

component PWMDriver is
    Port ( clk_100 : in STD_LOGIC;
           pwm_level : in STD_LOGIC_VECTOR (9 downto 0);
           pwm_out : out STD_LOGIC);
end component;

COMPONENT dist_mem_gen_0
  PORT (
    a : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    spo : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
  );
END COMPONENT;

signal sine_count : unsigned(16 downto 0) := (others => '0');
--constant sine_freq : integer := 98;
signal sine_freq : unsigned(8 downto 0) := (others => '0');

signal lut_addr : unsigned(9 downto 0) := (others => '0');
signal lut_out : std_logic_vector(9 downto 0) := (others => '0');

signal pwm_int : std_logic := '0';

begin

pd0 : PWMDriver
port map(
    clk_100 => CLK100MHZ,
    pwm_level => lut_out,
    pwm_out => pwm_int
);

dmg0 : dist_mem_gen_0
  PORT MAP (
    a => std_logic_vector(lut_addr),
    spo => lut_out
);

AUD_SD <= '1';
AUD_PWM <= '0' when pwm_int = '0' else 'Z';

sine_freq <= unsigned(SW);

process(CLK100MHZ)
begin
    if rising_edge(CLK100MHZ) then
        if sine_count = sine_freq then
            lut_addr <= lut_addr + 1;
            sine_count <= (others => '0');
        else
            sine_count <= sine_count + 1;
        end if;
    end if;
end process;

end Behavioral;
