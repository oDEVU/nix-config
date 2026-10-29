{ pkgs, lib, vars, ... }:

# VPN Politechniki Łódzkiej (OpenVPN) - https://uci.p.lodz.pl/openvpn

{
  networking.networkmanager = {
    enable = lib.mkDefault true;
    plugins = [ pkgs.networkmanager-openvpn ];
  };

  users.users.${vars.userName}.extraGroups = [ "networkmanager" ];

  environment.systemPackages = with pkgs; [
    openvpn
    networkmanagerapplet
  ];

  networking.firewall.checkReversePath = lib.mkDefault "loose";

  # ---------------------------------------------------------------------------
  # Konfiguracja ręczna (poza repo):
  #
  # 1. Pobierz z https://uci.p.lodz.pl/openvpn plik .ovpn dla studentów PŁ.
  # 2. Pobierz certyfikat + klucz (.p12) z https://sign.p.lodz.pl/
  #    Trzymaj w ~/.vpn/ :
  #       mkdir -p ~/.vpn && chmod 700 ~/.vpn
  #       chmod 600 ~/.vpn/*
  # 3. Zaimportuj profil:
  #       nmcli connection import type openvpn file ~/.vpn/<plik>.ovpn
  #    Potem w nm-connection-editor wskaż ścieżkę do .p12 jako
  #    certyfikat/klucz użytkownika i podaj hasło do klucza.
  # 4. Łączenie / rozłączanie:
  #       nmcli connection up <nazwa>
  #       nmcli connection down <nazwa>
  # ---------------------------------------------------------------------------
}
