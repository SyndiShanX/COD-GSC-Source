/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\doa.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\margwa;
#using scripts\shared\system_shared;
#namespace doa;

function main() {}

function onprecachegametype() {}

function onstartgametype() {}

function autoexec ignore_systems() {
  system::ignore("cybercom");
  system::ignore("healthoverlay");
  system::ignore("challenges");
  system::ignore("rank");
  system::ignore("hacker_tool");
  system::ignore("grapple");
  system::ignore("replay_gun");
  system::ignore("riotshield");
  system::ignore("oed");
  system::ignore("explosive_bolt");
  system::ignore("empgrenade");
  system::ignore("spawning");
  system::ignore("save");
}