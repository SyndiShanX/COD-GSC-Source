/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\credits_amb.csc
*****************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;

main() {
  declareMusicState("CREDITS");
  musicAlias("mx_credits", 0);
  musicWaitTillDone();
}