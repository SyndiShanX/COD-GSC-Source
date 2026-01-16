/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_challenges_tomb.csc
*************************************************/

#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_utility;
#namespace zm_challenges_tomb;

function autoexec __init__sytem__() {
  system::register("zm_challenges_tomb", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "challenges.challenge_complete_1", 21000, 2, "int", & zm_utility::setinventoryuimodels, 0, 1);
  clientfield::register("toplayer", "challenges.challenge_complete_2", 21000, 2, "int", & zm_utility::setinventoryuimodels, 0, 1);
  clientfield::register("toplayer", "challenges.challenge_complete_3", 21000, 2, "int", & zm_utility::setinventoryuimodels, 0, 1);
  clientfield::register("toplayer", "challenges.challenge_complete_4", 21000, 2, "int", & function_2d46c9fd, 0, 1);
}

function function_2d46c9fd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 2 && isspectating(localclientnum)) {
    return;
  }
  zm_utility::setsharedinventoryuimodels(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump);
}