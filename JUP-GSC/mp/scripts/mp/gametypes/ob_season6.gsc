/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\ob_season6.gsc
**************************************************/

#using script_3008e3767a2a503c;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\utility\game;
#namespace ob_season6;

function autoexec init() {
  level callback::add("ob_season_main", &main);
}

function main(params) {
  level callback::remove("ob_season_main", &main);

  if(scripts\mp\utility\game::function_966592fd716d49c7()) {
    function_faa8aae58d956943();
  }
}

function function_faa8aae58d956943() {
  callback::add("on_ai_killed", &function_d6516a2de5c30aca);
}

function private function_d6516a2de5c30aca(params) {
  level thread namespace_bc22b8386eb4de80::function_7502f58e600e74a2(self, params.eattacker, "new_loot_item_spawned", params.smeansofdeath);
}