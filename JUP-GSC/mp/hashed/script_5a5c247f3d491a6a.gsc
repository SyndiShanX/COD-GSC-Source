/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5a5c247f3d491a6a.gsc
*************************************************/

#using script_7edf952f8921aa6b;
#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\cp_mp\loot\common_item;
#using scripts\engine\utility;
#using scripts\mp\utility\perk;
#namespace ob_grenade_bandolier;

function private autoexec __init__system__() {
  system::register(#"ob_grenade_bandolier", undefined, undefined, &function_c781372c4c11366d);
}

function function_c781372c4c11366d() {
  level thread function_cb20a7fcb97fd9c3();

  registersharedfunc("ob_grenade_bandolier", "grenade_bandolier_give", &function_2cbcbfe35fda7eed);
}

function function_2cbcbfe35fda7eed() {
  self.var_194cdb94551bc049 = 1;
  giveperk("specialty_grenade_bandolier");
  self playSound("evt_ob_rr_grenade_bandolier_activate");
  self setclientomnvar("ui_ob_grenade_bandolier", 1);
}

function function_cb20a7fcb97fd9c3() {
  function_6e7290c8ee4f558b("<dev string:x1c>");
  devgui::function_b23a59dfb4ca49a1("<dev string:x36>", "<dev string:x50>", &scripts\cp_mp\loot\common_item::function_f8162124bbb6ece3);
  function_fe953f000498048f();
}

# /