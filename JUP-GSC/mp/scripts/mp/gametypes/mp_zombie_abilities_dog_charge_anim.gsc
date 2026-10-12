/************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\mp_zombie_abilities_dog_charge_anim.gsc
************************************************************************/

#namespace mp_zombie_abilities_dog_charge_anim;
#using_animtree("playerasmhellhound2");

function autoexec main() {
  level.scr_animtree["dog_charge"] = #animtree;
  level.scr_anim["dog_charge"]["hellhound_charge"] = % jup_mp_hellhound_sprint;
  level.scr_eventanim["dog_charge"]["hellhound_charge"] = % "jup_mp_hellhound_sprint";
  level.scr_anim["dog_charge"]["hellhound_hit_wall"] = % jup_mp_hellhound_charge_hit;
  level.scr_eventanim["dog_charge"]["hellhound_hit_wall"] = % "jup_mp_hellhound_charge_hit";
}