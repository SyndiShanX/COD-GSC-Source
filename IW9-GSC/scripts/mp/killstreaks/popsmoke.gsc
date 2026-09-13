/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\popsmoke.gsc
***********************************************/

_id_933806FB8408353D(_id_D874D4B7CF5258DB) {
  if(!isDefined(_id_D874D4B7CF5258DB))
    _id_D874D4B7CF5258DB = ["tag_origin"];

  if(!isarray(_id_D874D4B7CF5258DB))
    _id_D874D4B7CF5258DB = [_id_D874D4B7CF5258DB];

  owner = self.owner;

  foreach(_id_AC0E594AC96AA3A8, tag in _id_D874D4B7CF5258DB) {
    scripts\common\utility::_id_3677F2BE30FDD581(tag, "popsmoke");
    grenade = magicgrenademanual("popsmoke_grenade_mp", self gettagorigin(tag), anglestoup(self gettagangles(tag)) * 300);
    grenade.owner = owner;
    wait 0.25;
  }
}