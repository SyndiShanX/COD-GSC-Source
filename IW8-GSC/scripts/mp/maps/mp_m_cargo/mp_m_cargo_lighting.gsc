/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_cargo\mp_m_cargo_lighting.gsc
**************************************************************/

function main() {
  thread lighting_setup_dvars();
}

function lighting_setup_dvars() {
  setDvar("LKOLRONRNQ", 1500);
  setDvar("LTQMSPKRKO", 6);
  setDvar("MROOOROPKL", 8);
  setDvar("PKKMTTRQO", 8);
  setDvar("MNQKPNLOPT", 1);
  setDvar("NRSOTSLSSO", 1);
  thread ref_14051();
}

function ref_14051() {
  setDvar("NPONLLLSPL", 0.5);
  setDvar("LSNRQTOKRR", 2);
  setDvar("NTLKNLNPLK", 2);
  setDvar("TMNTMTQRM", 0);
  setDvar("sm_compressedSunShadowFiltering", 1);
  setDvar("sm_compressedSunShadowFilteringMaxRadius", 4);
}

function ref_11e8d() {
  setDvar("NPONLLLSPL", 0.18);
  setDvar("LSNRQTOKRR", 2);
  setDvar("NTLKNLNPLK", 3);
  setDvar("TMNTMTQRM", 1);
}