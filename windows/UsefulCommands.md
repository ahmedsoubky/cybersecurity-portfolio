# Windows Network Commands Cheat Sheet

A concise reference of essential Windows networking commands for troubleshooting, diagnostics, and system analysis.

| **Command** | **Description** | **Example Usage** |
|------------|------------------|-------------------|
| `arp -a` | Displays the ARP table (IP ↔ MAC mappings on the LAN) | `arp -a` |
| `ftp` | Opens an FTP connection to a remote server | `ftp 10.10.10.10` |
| `getmac` | Shows MAC addresses of all network interfaces | `getmac` |
| `hostname` | Displays the system hostname | `hostname` |
| `ipconfig` | Shows basic network interface configuration | `ipconfig` |
| `ipconfig /all` | Shows full network configuration including DHCP & DNS | `ipconfig /all` |
| `netstat -an` | Lists active TCP/UDP connections and listening ports | `netstat -an` |
| `nbtstat -a` | Displays NetBIOS name tables and sessions | `nbtstat -a` |
| `nslookup` | Resolves domain names to IP addresses | `nslookup www.wikipedia.org` |
| `net user` | Displays local user accounts | `net user` |
| `net localgroup` | Shows local groups and their members | `net localgroup` |
| `ping` | Tests IP connectivity | `ping 8.8.8.8` |
| `pathping` | Combines ping + tracert with packet‑loss analysis | `pathping commands.network` |
| `route print` | Displays the routing table | `route print` |
| `netstat -rn` | Displays routing table (similar to `route print`) | `netstat -rn` |
| `route delete` | Deletes a static route | `route delete 10.10.0.0 mask 255.255.0.0` |
| `route add` | Adds a static route | `route add 10.10.0.0 mask 255.255.255.0 10.10.0.1` |
| `telnet` | Opens a TCP connection to a host/port | `telnet 10.10.10.10` |
| `tracert` | Traces the path packets take to a destination | `tracert 10.10.10.10` |
| `mstsc` | Opens Remote Desktop Connection | `mstsc /v:192.168.0.10 /w:1600 /h:1200` |

---

## Notes

- These commands are useful for network diagnostics, troubleshooting, and system enumeration.
- Some commands (like `telnet`) may require enabling Windows optional features.
- Use administrative privileges when necessary (e.g., modifying routes).

