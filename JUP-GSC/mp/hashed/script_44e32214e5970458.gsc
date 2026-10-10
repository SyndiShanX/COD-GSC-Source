/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_44e32214e5970458.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\fogofwar;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\points;
#namespace namespace_ed1cfb3c9d4fe39f;

function init() {
  scripts\engine\utility::registersharedfunc("fogofwar", "isPlayerInGulag", &scripts\mp\gametypes\br_public::isplayeringulag);
  scripts\engine\utility::registersharedfunc("fogofwar", "giveXPWithText", &scripts\mp\utility\points::givexpwithtext);
  scripts\cp_mp\fogofwar::init();
}