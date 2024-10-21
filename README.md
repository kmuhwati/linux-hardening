# Comprehensive Linux System Hardening Project

Author: Kumbirai Muhwati

## Overview

This project provides a comprehensive Linux system hardening script designed to enhance the security of Debian-based Linux systems (e.g., Ubuntu). The script implements various security best practices and configurations to minimize potential vulnerabilities and strengthen the overall system security posture.

## WARNING

This script is primarily for educational purposes and as a starting point for system hardening. It should not be considered a complete security solution for production environments. Always thoroughly test and customize security measures for your specific needs and environment before applying them to production systems.

## Contents

- `harden_system.sh`: A comprehensive shell script that implements various hardening techniques.

## Hardening Techniques Implemented

1. System updates
2. Strong password policy configuration
3. PAM configuration for password complexity
4. SSH hardening (disabling root login, key-based authentication)
5. Firewall setup using UFW (Uncomplicated Firewall)
6. Installation and configuration of fail2ban
7. Disabling unused services
8. Removal of unnecessary packages
9. Securing shared memory
10. Setting appropriate permissions on sensitive files
11. Enabling process accounting
12. Configuring and enabling auditd
13. System logging configuration
14. Disabling USB storage
15. Setting GRUB password

## Prerequisites

- A Debian-based Linux system (e.g., Ubuntu)
- Root or sudo access
- Basic understanding of Linux system administration

## Usage

1. Clone this repository:
   ```
   git clone https://github.com/your-username/linux-hardening-project.git
   cd linux-hardening-project
   ```

2. Review the script content to understand the changes it will make:
   ```
   cat harden_system.sh
   ```

3. Make the script executable:
   ```
   chmod +x harden_system.sh
   ```

4. Run the script as root:
   ```
   sudo ./harden_system.sh
   ```

5. Follow any prompts during script execution.

6. Review the changes made by the script.

7. Reboot the system for all changes to take effect:
   ```
   sudo reboot
   ```

## Important Notes

- This script is designed for Debian-based systems. Some commands may not work on other distributions.
- Always backup your system before applying security changes.
- Regularly update and patch your system for the latest security fixes.
- This script provides a starting point for system hardening. Additional measures should be implemented based on specific security requirements and threat models.
- Some changes (like disabling USB storage) may impact system functionality. Ensure you understand the implications of each hardening measure.

## Customization

Before running the script in a production environment, consider the following customizations:

- Modify the SSH `AllowUsers` directive to include your specific username(s).
- Adjust firewall rules based on your specific needs.
- Review and modify fail2ban settings as necessary.
- Customize log retention policies and auditd rules.

## Verification

After running the script and rebooting, verify the changes:

1. Check SSH configuration: `sudo nano /etc/ssh/sshd_config`
2. Verify firewall status: `sudo ufw status`
3. Check fail2ban status: `sudo systemctl status fail2ban`
4. Verify process accounting: `sudo accton`
5. Check auditd status: `sudo systemctl status auditd`

## Further Hardening

This script provides a solid foundation for system hardening, but security is an ongoing process. Consider these additional steps:

1. Implement regular security audits
2. Set up intrusion detection systems (IDS) like OSSEC
3. Configure and use SELinux or AppArmor
4. Implement file integrity monitoring
5. Set up centralized logging
6. Conduct regular vulnerability assessments

## Further Reading

For more comprehensive system hardening guidelines, refer to:

- CIS Benchmarks: https://www.cisecurity.org/cis-benchmarks/
- NIST Special Publication 800-123: https://csrc.nist.gov/publications/detail/sp/800-123/final
- Ubuntu Security Guide: https://ubuntu.com/security/certifications/docs/usg

## Contributing

Contributions to improve this hardening script are welcome. Please submit pull requests or open issues to suggest improvements or report bugs.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Disclaimer

The author and contributors of this script are not responsible for any damage or data loss caused by the use of this script. Use at your own risk and always test in a non-production environment first.

Remember, system security is an ongoing process that requires regular attention, updates, and adaptation to new threats and best practices.