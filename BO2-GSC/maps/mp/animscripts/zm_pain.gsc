/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\animscripts\zm_pain.gsc
*******************************************/

#include common_scripts\utility;
#include maps\mp\animscripts\shared;
#include maps\mp\animscripts\utility;
#include maps\mp\animscripts\zm_utility;

main() {
  self setflashbanged(0);

  if(isDefined(self.longdeathstarting)) {
    self waittill("killanimscript");
    return;
  }

  if(self.a.disablepain)
    return;
}