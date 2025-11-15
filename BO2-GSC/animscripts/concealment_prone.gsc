/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\concealment_prone.gsc
*********************************************/

#include animscripts\utility;
#include animscripts\cover_prone;

main() {
  self trackscriptstate("Concealment Prone Main", "code");
  self endon("killanimscript");
  animscripts\utility::initialize("concealment_prone");
  self animscripts\cover_prone::main();
}