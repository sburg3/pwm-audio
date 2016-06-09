----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2015 04:56:24 PM
-- Design Name: 
-- Module Name: PWMAudio_TB - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PWMAudio_TB is
--  Port ( );
end PWMAudio_TB;

architecture Behavioral of PWMAudio_TB is

component PWMAudio is
    Port ( CLK100MHZ : in STD_LOGIC;
           AUD_PWM : out STD_LOGIC;
           AUD_SD : out STD_LOGIC;
           SW : in STD_LOGIC_VECTOR(8 downto 0));
end component;

signal clk_100 : std_logic := '0';
signal aud_pwm : std_logic := '0';
signal aud_sd : std_logic := '0';
signal sw : std_logic_vector(8 downto 0) := "000000000";

begin

clk_100 <= not clk_100 after 5ns;

pa0 : PWMAudio
port map(
    CLK100MHZ => clk_100,
    AUD_PWM => aud_pwm,
    AUD_SD => aud_sd,
    SW => sw
);


end Behavioral;
