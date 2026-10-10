/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5961052449eb875f.gsc
*************************************************/

#using scripts\engine\utility;
#namespace namespace_9a99950edac8810a;

function function_db3156cab6c25766(var_eb8eb3b902492463) {
  self endon("disconnect");
  self endon("pull_out_of_gulag");
  self waittill("gulag_start", var_e73f82f58eb3128);
  self[[var_eb8eb3b902492463]](var_e73f82f58eb3128);
}

function function_7f25d3119f627905(var_5fe0efc8a09cabe4) {
  self endon("disconnect");
  self endon("pull_out_of_gulag");
  self waittill("enter_gulag", var_e73f82f58eb3128);
  self[[var_5fe0efc8a09cabe4]](var_e73f82f58eb3128);
}

function function_b3e2a55102596658(var_70fd3674ca1df0d5) {
  self endon("disconnect");
  self endon("pull_out_of_gulag");
  self waittill("beginNewFight");
  self[[var_70fd3674ca1df0d5]]();
}

function function_8efd0509e8d63ca9(var_3a31777466550e0) {
  self endon("disconnect");
  msg = waittill_any_return_4("gulag_end", "pull_out_of_gulag", "gulagLost", "death");
  self[[var_3a31777466550e0]](msg == "gulag_end" || msg == "pull_out_of_gulag");
}

function function_88b1ad5e2a6d9e6d(var_e13f125ac9e102fc) {
  self endon("disconnect");
  self endon("beginNewFight");
  waittill_any_return_2("gulag_end", "pull_out_of_gulag");
  self[[var_e13f125ac9e102fc]]();
}