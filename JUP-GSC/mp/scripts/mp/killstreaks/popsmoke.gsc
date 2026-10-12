/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\popsmoke.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#namespace popsmoke;

function function_933806fb8408353d(smoketags) {
  if(!isDefined(smoketags)) {
    smoketags = ["tag_origin"];
  }

  if(!isarray(smoketags)) {
    smoketags = [smoketags];
  }

  owner = self.owner;

  foreach(tag in smoketags) {
    function_3677f2be30fdd581(tag, "popsmoke");
    grenade = magicgrenademanual("popsmoke_grenade_mp", self gettagorigin(tag), anglestoup(self gettagangles(tag)) * 300);
    grenade.owner = owner;
    wait 0.25;
  }
}