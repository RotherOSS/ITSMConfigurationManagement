# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2026 Rother OSS GmbH, https://otobo.io/
# --
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
# --

package Kernel::Language::el_ITSMConfigurationManagement;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminGenericInterfaceOperationConfigItem
    $Self->{Translation}->{'General operation data'} = 'Γενικά στοιχεία λειτουργίας';
    $Self->{Translation}->{'Settings for incoming request data'} = 'Ρυθμίσεις για εισερχόμενα δεδομένα αίτησης';
    $Self->{Translation}->{'Settings for outgoing response data'} = 'Ρυθμίσεις για δεδομένα εξερχόμενης απάντησης';

    # Template: AdminITSMConfigItem
    $Self->{Translation}->{'Config Item Management'} = 'Λειτουργικό σύστημα διακομιστή';
    $Self->{Translation}->{'Change class definition'} = 'Αλλαγή ορισμού κλάσης';
    $Self->{Translation}->{'Change role definition'} = 'Αλλαγή ορισμού ρόλου';
    $Self->{Translation}->{'Ready2Import Class Bundles'} = 'Δέσμες κλάσεων Ready2Import';
    $Self->{Translation}->{'Here you can import Ready2Import class bundles showcasing our most usual config items. Please note that some additional configuration may be required.'} =
        'Εδώ μπορείτε να εισαγάγετε δέσμες κλάσεων Ready2Import που παρουσιάζουν τα πιο συνηθισμένα στοιχεία ρυθμίσεων. Παρακαλούμε σημειώστε ότι ενδέχεται να απαιτούνται κάποιες πρόσθετες ρυθμίσεις.';
    $Self->{Translation}->{'Update existing entities'} = 'Ενημέρωση υφιστάμενων οντοτήτων';
    $Self->{Translation}->{'Import Ready2Adopt class bundles'} = 'Εισαγωγή πακέτων κλάσεων Ready2Adopt';
    $Self->{Translation}->{'Config Item Class'} = 'Config Item Class';
    $Self->{Translation}->{'Config Item Role'} = 'Ρόλος στοιχείου διαμόρφωσης';

    # Template: AgentITSMConfigItemAdd
    $Self->{Translation}->{'Config Item'} = 'Στοιχείο διαμόρφωσης';
    $Self->{Translation}->{'Filter for Classes'} = 'Φίλτρο για τάξεις';
    $Self->{Translation}->{'Select a Class from the list to create a new Config Item.'} = 'Επιλέξτε μια κλάση από τη λίστα για να δημιουργήσετε ένα νέο στοιχείο διαμόρφωσης.';
    $Self->{Translation}->{'Class'} = 'Τάξη';

    # Template: AgentITSMConfigItemBulk
    $Self->{Translation}->{'ITSM ConfigItem Bulk Action'} = 'Μαζική ενέργεια ITSM ConfigItem';
    $Self->{Translation}->{'Deployment state'} = 'Κατάσταση ανάπτυξης';
    $Self->{Translation}->{'Incident state'} = 'Κατάσταση συμβάντος';
    $Self->{Translation}->{'Link to another'} = 'Σύνδεσμος σε άλλο';
    $Self->{Translation}->{'Invalid Configuration Item number!'} = 'Μη έγκυρος αριθμός στοιχείου διαμόρφωσης!';
    $Self->{Translation}->{'The number of another Configuration Item to link with.'} = 'Ο αριθμός ενός άλλου στοιχείου διαμόρφωσης με το οποίο θα συνδεθεί.';

    # Template: AgentITSMConfigItemDelete
    $Self->{Translation}->{'Do you really want to delete this config item?'} = 'Δίκτυο';

    # Template: AgentITSMConfigItemEdit
    $Self->{Translation}->{'The name of this config item'} = 'Το όνομα αυτού του στοιχείου διαμόρφωσης';
    $Self->{Translation}->{'Name is already in use by the ConfigItems with the following Number(s): %s'} =
        'Το όνομα χρησιμοποιείται ήδη από τα ConfigItems με τον ακόλουθο αριθμό(-ους): %s';
    $Self->{Translation}->{'Version Number'} = 'Αριθμός έκδοσης';
    $Self->{Translation}->{'Version number of this config item'} = 'Αριθμός έκδοσης αυτού του στοιχείου διαμόρφωσης';
    $Self->{Translation}->{'Version Number is already in use by the ConfigItems with the following Number(s): %s'} =
        'Ο αριθμός έκδοσης χρησιμοποιείται ήδη από τα ConfigItems με τον(τους) ακόλουθο(-ους) αριθμό(-ους): %s';
    $Self->{Translation}->{'Deployment State'} = 'Κατάσταση ανάπτυξης';
    $Self->{Translation}->{'Incident State'} = 'Κατάσταση συμβάντος';

    # Template: AgentITSMConfigItemHistory
    $Self->{Translation}->{'History of Config Item: %s'} = 'Ιστορικό του στοιχείου διαμόρφωσης: %s';
    $Self->{Translation}->{'History Content'} = 'Ιστορία Περιεχόμενο';
    $Self->{Translation}->{'Createtime'} = 'Χρόνος δημιουργίας';
    $Self->{Translation}->{'Zoom view'} = 'Προβολή ζουμ';

    # Template: AgentITSMConfigItemOverviewNavBar
    $Self->{Translation}->{'Config Items per page'} = 'Config Στοιχεία ανά σελίδα';

    # Template: AgentITSMConfigItemOverviewSmall
    $Self->{Translation}->{'No config item data found.'} = 'Δεν βρέθηκαν δεδομένα στοιχείου διαμόρφωσης.';
    $Self->{Translation}->{'Select this config item'} = 'Επιλέξτε αυτό το στοιχείο διαμόρφωσης';

    # Template: AgentITSMConfigItemSearch
    $Self->{Translation}->{'Run Search'} = 'Εκτέλεση αναζήτησης';
    $Self->{Translation}->{'Also search in previous versions?'} = 'Επίσης αναζήτηση σε προηγούμενες εκδόσεις?';

    # Template: AgentITSMConfigItemTreeView
    $Self->{Translation}->{'TreeView for ConfigItem'} = 'TreeView για ConfigItem';
    $Self->{Translation}->{'Depth Level'} = 'Επίπεδο βάθους';
    $Self->{Translation}->{'Zoom In/Out'} = 'Μεγέθυνση/Σμίκρυνση';
    $Self->{Translation}->{'Max links level reached for ConfigItem!'} = 'Επίτευξη μέγιστου επιπέδου συνδέσεων για το ConfigItem!';

    # Template: AgentITSMConfigItemZoom
    $Self->{Translation}->{'Configuration Item'} = 'Στοιχείο διαμόρφωσης';
    $Self->{Translation}->{'Configuration Item Information'} = 'Πληροφορίες στοιχείου διαμόρφωσης';
    $Self->{Translation}->{'Current Deployment State'} = 'Τρέχουσα κατάσταση ανάπτυξης';
    $Self->{Translation}->{'Current Incident State'} = 'Τρέχουσα κατάσταση συμβάντος';
    $Self->{Translation}->{'Last changed'} = 'Τελευταία αλλαγή';
    $Self->{Translation}->{'Last changed by'} = 'Τελευταία αλλαγή από';

    # Template: CustomerITSMConfigItem
    $Self->{Translation}->{'Your ConfigItems'} = 'Τα ConfigItems σας';

    # Template: CustomerITSMConfigItemSearch
    $Self->{Translation}->{'ConfigItem Search'} = 'Αναζήτηση ConfigItem';

    # Template: AdminACL
    $Self->{Translation}->{'Object Type'} = 'Τύπος αντικειμένου';

    # Template: AdminDynamicFieldScreen
    $Self->{Translation}->{'Filter by object type'} = '';

    # JS Template: ClassImportConfirm
    $Self->{Translation}->{'The following classes will be imported'} = 'Θα εισαχθούν οι ακόλουθες κλάσεις';
    $Self->{Translation}->{'The following roles will be imported'} = 'Θα εισαχθούν οι ακόλουθοι ρόλοι';
    $Self->{Translation}->{'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.'} =
        'Σημειώστε ότι θα δημιουργηθούν επίσης τα αντίστοιχα δυναμικά πεδία και οι κλάσεις GeneralCatalog και δεν υπάρχει αυτόματη αφαίρεση.';
    $Self->{Translation}->{'Do you want to proceed?'} = 'Θέλετε να προχωρήσετε;';

    # Perl Module: Kernel/Modules/AdminITSMConfigItem.pm
    $Self->{Translation}->{'Need ExampleClasses!'} = 'Χρειάζεστε ExampleClasses!';
    $Self->{Translation}->{'Definition is no valid YAML hash.'} = 'Ο ορισμός δεν είναι έγκυρος κατακερματισμός YAML.';

    # Perl Module: Kernel/Modules/AgentITSMConfigItem.pm
    $Self->{Translation}->{'Overview: ITSM ConfigItem'} = 'Επισκόπηση: ITSM ConfigItem';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemBulk.pm
    $Self->{Translation}->{'No ConfigItemID is given!'} = 'Δεν έχει δοθεί ConfigItemID!';
    $Self->{Translation}->{'You need at least one selected Configuration Item!'} = 'Χρειάζεστε τουλάχιστον ένα επιλεγμένο στοιχείο διαμόρφωσης!';
    $Self->{Translation}->{'You don\'t have write access to this configuration item: %s.'} =
        'Δεν έχετε πρόσβαση εγγραφής σε αυτό το στοιχείο διαμόρφωσης: %s.';
    $Self->{Translation}->{'No definition was defined for class %s!'} = 'Δεν έχει οριστεί ορισμός για την κλάση %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemDelete.pm
    $Self->{Translation}->{'Config item "%s" not found in database!'} = 'Το στοιχείο διαμόρφωσης "%s" δεν βρέθηκε στη βάση δεδομένων!';
    $Self->{Translation}->{'Was not able to delete the configitem ID %s!'} = 'Δεν μπόρεσε να διαγράψει το configitem ID %s!';
    $Self->{Translation}->{'No version found for ConfigItemID %s!'} = 'Δεν βρέθηκε έκδοση για το ConfigItemID %s!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemEdit.pm
    $Self->{Translation}->{'No ConfigItemID, DuplicateID or ClassID is given!'} = 'Δεν δίνεται ConfigItemID, DuplicateID ή ClassID!';
    $Self->{Translation}->{'No access is given!'} = 'Δεν δίνεται καμία πρόσβαση!';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemHistory.pm
    $Self->{Translation}->{'Can\'t show history, no ConfigItemID is given!'} = 'Δεν μπορεί να εμφανιστεί το ιστορικό, δεν δίνεται ConfigItemID!';
    $Self->{Translation}->{'Can\'t show history, no access rights given!'} = 'Δεν μπορεί να εμφανιστεί το ιστορικό, δεν έχουν δοθεί δικαιώματα πρόσβασης!';
    $Self->{Translation}->{'New ConfigItem (ID=%s)'} = 'Νέο ConfigItem (ID=%s)';
    $Self->{Translation}->{'New version (ID=%s)'} = 'Νέα έκδοση (ID=%s)';
    $Self->{Translation}->{'Deployment state updated (new=%s, old=%s)'} = 'Παράμετροι για τις ομάδες δικαιωμάτων του παραδείγματος των γενικών χαρακτηριστικών καταλόγου.';
    $Self->{Translation}->{'Incident state updated (new=%s, old=%s)'} = 'Ενημέρωση κατάστασης περιστατικού (new=%s, old=%s)';
    $Self->{Translation}->{'ConfigItem (ID=%s) deleted'} = 'ConfigItem (ID=%s) διαγράφηκε';
    $Self->{Translation}->{'Link to %s (type=%s) added'} = 'Προστέθηκε σύνδεσμος προς %s (type=%s)';
    $Self->{Translation}->{'Link to %s (type=%s) deleted'} = 'Διαγραφή συνδέσμου προς %s (type=%s)';
    $Self->{Translation}->{'ConfigItem definition updated (ID=%s)'} = 'Ο ορισμός ConfigItem ενημερώθηκε (ID=%s)';
    $Self->{Translation}->{'Name updated (new=%s, old=%s)'} = 'Όνομα ενημερωμένο (new=%s, old=%s)';
    $Self->{Translation}->{'Attribute %s updated from "%s" to "%s"'} = 'Δεν μπορεί να εμφανιστεί το στοιχείο, δεν έχουν δοθεί δικαιώματα πρόσβασης για το ConfigItem!';
    $Self->{Translation}->{'Version %s deleted'} = 'Έκδοση %s διαγράφηκε';
    $Self->{Translation}->{'File "%s" uploaded'} = '';
    $Self->{Translation}->{'File "%s" removed'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemPrint.pm
    $Self->{Translation}->{'No ConfigItemID or VersionID is given!'} = 'Δεν δίνεται ConfigItemID ή VersionID!';
    $Self->{Translation}->{'Can\'t show config item, no access rights given!'} = 'Δεν μπορεί να εμφανιστεί το στοιχείο διαμόρφωσης, δεν έχουν δοθεί δικαιώματα πρόσβασης!';
    $Self->{Translation}->{'ConfigItemID %s not found in database!'} = 'Το ConfigItemID %s δεν βρέθηκε στη βάση δεδομένων!';
    $Self->{Translation}->{'ConfigItem'} = 'ConfigItem';
    $Self->{Translation}->{'printed by %s at %s'} = 'τυπωμένο από %s στο %s';
    $Self->{Translation}->{'Referenced by'} = '';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemSearch.pm
    $Self->{Translation}->{'Invalid ClassID!'} = 'Μη έγκυρο ClassID!';
    $Self->{Translation}->{'No ClassID is given!'} = 'Δεν δίνεται ClassID!';
    $Self->{Translation}->{'No access rights for this class given!'} = 'Δεν δίνονται δικαιώματα πρόσβασης για αυτή την κλάση!';
    $Self->{Translation}->{'No Result!'} = 'Κανένα αποτέλεσμα!';
    $Self->{Translation}->{'Config Item Search Results'} = 'Αποτελέσματα αναζήτησης αντικειμένου Config';

    # Perl Module: Kernel/Modules/AgentITSMConfigItemZoom.pm
    $Self->{Translation}->{'Can\'t show item, no access rights for ConfigItem are given!'} =
        'Δεν μπορεί να εμφανιστεί το στοιχείο, δεν έχουν δοθεί δικαιώματα πρόσβασης για το ConfigItem!';
    $Self->{Translation}->{'ConfigItem not found!'} = 'Το ConfigItem δεν βρέθηκε!';
    $Self->{Translation}->{'No versions found!'} = 'Δεν βρέθηκαν εκδόσεις!';
    $Self->{Translation}->{'operational'} = 'λειτουργικό';
    $Self->{Translation}->{'warning'} = 'προειδοποίηση';
    $Self->{Translation}->{'incident'} = 'περιστατικό';
    $Self->{Translation}->{'The deployment state of this config item'} = 'Η κατάσταση ανάπτυξης αυτού του στοιχείου διαμόρφωσης';
    $Self->{Translation}->{'The incident state of this config item'} = 'Η κατάσταση συμβάντος αυτού του στοιχείου διαμόρφωσης';

    # Perl Module: Kernel/Modules/CustomerITSMConfigItemSearch.pm
    $Self->{Translation}->{'No permission'} = 'Δεν υπάρχει άδεια';
    $Self->{Translation}->{'Filter invalid!'} = 'Φίλτρο άκυρο!';
    $Self->{Translation}->{'Search params invalid!'} = 'Οι παραμέτρους αναζήτησης είναι άκυρες!';

    # Perl Module: Kernel/Output/HTML/Dashboard/ITSMConfigItemGeneric.pm
    $Self->{Translation}->{'Shown config items'} = 'Εμφανίζονται στοιχεία διαμόρφωσης';
    $Self->{Translation}->{'Deployment State Type'} = 'Τύπος κατάστασης ανάπτυξης';
    $Self->{Translation}->{'Current Incident State Type'} = 'Τρέχον περιστατικό Τύπος κατάστασης';

    # Perl Module: Kernel/Output/HTML/ITSMConfigItem/LayoutDate.pm
    $Self->{Translation}->{'Between'} = 'Μεταξύ';

    # Perl Module: Kernel/System/DynamicField/Driver/ConfigItem.pm
    $Self->{Translation}->{'Class restrictions for the config item'} = 'Περιορισμοί κλάσης για το στοιχείο διαμόρφωσης';
    $Self->{Translation}->{'Select one or more classes to restrict selectable config items'} =
        'Επιλέξτε μία ή περισσότερες κλάσεις για να περιορίσετε τα επιλέξιμα στοιχεία διαμόρφωσης';
    $Self->{Translation}->{'Deployment state restrictions for the config item'} = '';
    $Self->{Translation}->{'Select one or more deployment states to restrict selectable config items'} =
        '';
    $Self->{Translation}->{'Dynamic (ConfigItem)'} = 'Δυναμικό (ConfigItem)';
    $Self->{Translation}->{'Static (Version)'} = 'Static (Έκδοση)';
    $Self->{Translation}->{'Link Referencing Type'} = 'Τύπος αναφοράς συνδέσμου';
    $Self->{Translation}->{'Whether this link applies to the ConfigItem or the static version of the referencing object. Current Incident State calculation only is performed on dynamic links.'} =
        'Εάν αυτή η σύνδεση ισχύει για το ConfigItem ή τη στατική έκδοση του αντικειμένου αναφοράς. Ο υπολογισμός της τρέχουσας κατάστασης συμβάντος εκτελείται μόνο σε δυναμικές συνδέσεις.';
    $Self->{Translation}->{'Select the attribute which config items will be searched by'} = 'Επιλέξτε το χαρακτηριστικό με βάση το οποίο θα γίνεται η αναζήτηση των στοιχείων διαμόρφωσης';

    # Perl Module: Kernel/System/ITSMConfigItem/Definition.pm
    $Self->{Translation}->{'Base structure is not valid. Please provide a hash with data in YAML format.'} =
        'Η βασική δομή δεν είναι έγκυρη. Παρακαλούμε δώστε ένα hash με δεδομένα σε μορφή YAML.';
    $Self->{Translation}->{'Starting the YAML string with \'---\' is required.'} = 'Απαιτείται η έναρξη της συμβολοσειράς YAML με \'---\'.';

    # Perl Module: Kernel/System/ITSMConfigItem/Link.pm
    $Self->{Translation}->{'Could not purge the table configitem_link.'} = 'Δεν ήταν δυνατή η εκκαθάριση του πίνακα configitem_link.';
    $Self->{Translation}->{'No relevant dynamic fields were found'} = 'Δεν βρέθηκαν σχετικά δυναμικά πεδία';
    $Self->{Translation}->{'Could not insert into the table configitem_link'} = 'Δεν ήταν δυνατή η εισαγωγή στον πίνακα configitem_link';
    $Self->{Translation}->{'Inserted 0 rows into the table configitem_link'} = 'Εισήχθησαν 0 γραμμές στον πίνακα configitem_link';

    # Perl Module: Kernel/System/ImportExport/ObjectBackend/ITSMConfigItem.pm
    $Self->{Translation}->{'Maximum number of one element'} = 'Μέγιστος αριθμός ενός στοιχείου';
    $Self->{Translation}->{'Maximum number of one Set dynamic field element'} = '';
    $Self->{Translation}->{'Maximum number of one element within a Set dynamic field element'} =
        '';
    $Self->{Translation}->{'Import/Export attachments (as the last entries per line)'} = 'Εισαγωγή/Εξαγωγή συνημμένων (ως οι τελευταίες καταχωρήσεις ανά γραμμή)';
    $Self->{Translation}->{'Version String'} = 'Συμβολοσειρά έκδοσης';

    # Perl Module: Kernel/Modules/AdminDynamicField.pm
    $Self->{Translation}->{'Error synchronizing the definitions. Please check the log.'} = 'Σφάλμα συγχρονισμού των ορισμών. Ελέγξτε το αρχείο καταγραφής.';
    $Self->{Translation}->{'You have ITSMConfigItem definitions which are not synchronized. Please deploy your ITSMConfigItem dynamic field changes.'} =
        'Έχετε ορισμούς ITSMConfigItem που δεν είναι συγχρονισμένοι. Παρακαλούμε αναπτύξτε τις αλλαγές των δυναμικών πεδίων ITSMConfigItem.';

    # Database XML / SOPM Definition: ITSMConfigurationManagement.sopm
    $Self->{Translation}->{'Expired'} = 'Λειτούργησε';
    $Self->{Translation}->{'Maintenance'} = 'Συντήρηση';
    $Self->{Translation}->{'Pilot'} = 'Πιλότος';
    $Self->{Translation}->{'Planned'} = 'Προγραμματισμένο';
    $Self->{Translation}->{'Repair'} = 'Επισκευή';
    $Self->{Translation}->{'Retired'} = 'Συνταξιούχος';
    $Self->{Translation}->{'Review'} = 'Ανασκόπηση';
    $Self->{Translation}->{'Test/QA'} = 'Δοκιμή/QA';

    # JS File: ITSM.Admin.ITSMConfigItem
    $Self->{Translation}->{'Overview and Confirmation'} = 'Επισκόπηση και επιβεβαίωση';
    $Self->{Translation}->{'Importing classes/roles and their related fields'} = 'Εισαγωγή κλάσεων/ρόλων και των σχετικών πεδίων τους';
    $Self->{Translation}->{'An error occurred during class import.'} = 'Προέκυψε σφάλμα κατά την εισαγωγή της κλάσης.';

    # SysConfig
    $Self->{Translation}->{'0 - Hidden'} = '0 - Κρυφό';
    $Self->{Translation}->{'1 - Shown'} = '1 - Εμφανίζεται';
    $Self->{Translation}->{'A mapping of inner field names used in the Process Management TransitionActions ConfigItemAdd and -Update. The keys are the names of the set inner fields of the set with object type ticket which will be used to create/update the CI, and the values are the names of the inner fields of the set with object type ITSMConfigItem.'} =
        '';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the agent interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Επιτρέπει εκτεταμένες συνθήκες αναζήτησης στην αναζήτηση στοιχείων διαμόρφωσης της διεπαφής πράκτορα. Με αυτή τη δυνατότητα μπορείτε να αναζητήσετε π.χ. το όνομα του στοιχείου διαμόρφωσης με τέτοιου είδους συνθήκες όπως "(*key1*&&*key2*)" ή "(*key1*||*key2*)".';
    $Self->{Translation}->{'Allows extended search conditions in config item search of the customer interface. With this feature you can search e. g. config item name with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".'} =
        'Επιτρέπει εκτεταμένες συνθήκες αναζήτησης στην αναζήτηση στοιχείων διαμόρφωσης της διεπαφής πελατών. Με αυτή τη δυνατότητα μπορείτε να αναζητήσετε π.χ. το όνομα του στοιχείου διαμόρφωσης με τέτοιου είδους συνθήκες όπως "(*key1*&&*key2*)" ή "(*key1*||*key2*)".';
    $Self->{Translation}->{'Assigned CIs'} = 'Εκχωρηθέντα CIs';
    $Self->{Translation}->{'At a specific time point create a ticket for config items, if the configured requirements are met. The time point is determined by the value of the dynamic field of type date configured under "TimeCIKey" of the ConfigItem, and modified by "TimeModifier". If the latter can be either just a number, or a sign (+/-), a number, and an unit (d/h/m): "7" is equivalent to "+7d". The DynamicField "Ticket->DynamicField" will be used to mark created tickets - it has to exist. The flags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER and DATE, will be substituted with the respective values in "Ticket->Text".'} =
        '';
    $Self->{Translation}->{'Attributes for license accounting.'} = '';
    $Self->{Translation}->{'Attributes for licenses counting, where "TotalLicensesDF", "AvailableLicensesDF" and "LicenseReferenceDF" are the names of the dynamic fields used to track the remaining licenses. If used, only deployment states in "ValidDeplStates" are considered. If a threshold is defined in "MinimumLicenses", a ticket will automatically be created if less licenses are available. For this, the checkbox dynamic field "Ticket->DynamicField" must exist. The tags \<OTOBO_CONFIGITEM_X\> where X can be NAME, NUMBER, LICENSES_AVAIL and LICENSES_MIN, will be substituted with the respective values in "Ticket->Text" by the config item name, number, available licenses, and minimum required available licenses, respectively.'} =
        '';
    $Self->{Translation}->{'CIs assigned to customer company'} = 'CIs που ανατίθενται στην εταιρεία-πελάτη';
    $Self->{Translation}->{'CIs assigned to customer user'} = 'CIs που έχουν εκχωρηθεί σε χρήστη πελάτη';
    $Self->{Translation}->{'CMDB Settings'} = 'Ρυθμίσεις CMDB';
    $Self->{Translation}->{'Check for a unique name only within the same ConfigItem class (\'class\') or globally (\'global\'), which means every existing ConfigItem is taken into account when looking for duplicates.'} =
        'Ελέγξτε για ένα μοναδικό όνομα μόνο εντός της ίδιας κλάσης ConfigItem (\'class\') ή σε παγκόσμιο επίπεδο (\'global\'), πράγμα που σημαίνει ότι κάθε υπάρχον ConfigItem λαμβάνεται υπόψη κατά την αναζήτηση αντιγράφων.';
    $Self->{Translation}->{'Choose a module to enforce a naming scheme.'} = 'Επιλέξτε μια ενότητα για την επιβολή ενός σχήματος ονοματοδοσίας.';
    $Self->{Translation}->{'Choose a module to enforce a number scheme.'} = 'Επιλέξτε μια ενότητα για την επιβολή ενός αριθμητικού συστήματος.';
    $Self->{Translation}->{'Choose a module to enforce a version string scheme.'} = 'Επιλέξτε μια ενότητα για την επιβολή ενός σχήματος συμβολοσειράς εκδόσεων.';
    $Self->{Translation}->{'Choose attributes to trigger the creation of a new version.'} = 'Επιλέξτε χαρακτηριστικά για να ενεργοποιήσετε τη δημιουργία μιας νέας έκδοσης.';
    $Self->{Translation}->{'Choose categories to assign to this config item class.'} = 'Επιλέξτε κατηγορίες για να αναθέσετε σε αυτή την κατηγορία στοιχείων διαμόρφωσης.';
    $Self->{Translation}->{'Column config item filters for ConfigItem Overview.'} = 'Φίλτρα στοιχείων παραμέτρων στήλης για την Επισκόπηση στοιχείων παραμέτρων.';
    $Self->{Translation}->{'Columns that can be filtered in the config item overview of the agent interface. Note: Only Config Item attributes and Dynamic Fields (DynamicField_NameX) are allowed.'} =
        'Στήλες που μπορούν να φιλτραριστούν στην επισκόπηση στοιχείων διαμόρφωσης του περιβάλλοντος εργασίας του πράκτορα. Σημείωση: Επιτρέπονται μόνο τα χαρακτηριστικά στοιχείων διαμόρφωσης και τα δυναμικά πεδία (DynamicField_NameX).';
    $Self->{Translation}->{'Config Items'} = 'Στοιχεία διαμόρφωσης';
    $Self->{Translation}->{'Config item add.'} = 'Προσθήκη στοιχείου διαμόρφωσης.';
    $Self->{Translation}->{'Config item edit.'} = 'Επεξεργασία στοιχείου διαμόρφωσης.';
    $Self->{Translation}->{'Config item event module that enables accounting licenses for a given config item.'} =
        '';
    $Self->{Translation}->{'Config item event module that enables logging to history in the agent interface.'} =
        'Μονάδα συμβάντων στοιχείου ρύθμισης παραμέτρων που επιτρέπει την καταγραφή στο ιστορικό στη διεπαφή του πράκτορα.';
    $Self->{Translation}->{'Config item event module that updates config items to their current definition.'} =
        'Μονάδα συμβάντων στοιχείων διαμόρφωσης που ενημερώνει τα στοιχεία διαμόρφωσης στον τρέχοντα ορισμό τους.';
    $Self->{Translation}->{'Config item history.'} = 'Έξοδος';
    $Self->{Translation}->{'Config item print.'} = 'Εκτύπωση στοιχείων διαμόρφωσης.';
    $Self->{Translation}->{'Config item zoom.'} = 'Ρύθμιση ζουμ αντικειμένου.';
    $Self->{Translation}->{'ConfigItem Tree View'} = 'Δενδρική προβολή ConfigItem';
    $Self->{Translation}->{'ConfigItem Version'} = 'ConfigItem Έκδοση';
    $Self->{Translation}->{'ConfigItems of the following classes will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Τα ConfigItems των ακόλουθων κλάσεων δεν θα αποθηκεύονται στο διακομιστή Elasticsearch. Για να εφαρμοστεί αυτό σε υπάρχοντα CI, η μετάβαση CI πρέπει να εκτελεστεί μέσω της κονσόλας, μετά την αλλαγή αυτής της επιλογής.';
    $Self->{Translation}->{'ConfigItems with the following deployment states will not be stored on the Elasticsearch server. To apply this to existing CIs, the CI migration has to be run via console, after changing this option.'} =
        'Τα ConfigItems με τις ακόλουθες καταστάσεις ανάπτυξης δεν θα αποθηκεύονται στο διακομιστή Elasticsearch. Για να εφαρμοστεί αυτό σε υπάρχοντα CIs, η μετάβαση CI πρέπει να εκτελεστεί μέσω της κονσόλας, μετά την αλλαγή αυτής της επιλογής.';
    $Self->{Translation}->{'Configuration Item Limit'} = 'Όριο στοιχείου διαμόρφωσης';
    $Self->{Translation}->{'Configuration Item limit per page.'} = 'Όριο στοιχείων διαμόρφωσης ανά σελίδα.';
    $Self->{Translation}->{'Configuration Management Database.'} = 'Βάση δεδομένων διαχείρισης διαμόρφωσης.';
    $Self->{Translation}->{'Configuration item bulk module.'} = 'Στοιχείο διαμόρφωσης μαζικής μονάδας.';
    $Self->{Translation}->{'Configuration item search backend router of the agent interface.'} =
        'Στοιχείο διαμόρφωσης στοιχείο αναζήτησης backend router της διασύνδεσης πράκτορα.';
    $Self->{Translation}->{'Configure the columns which are available for viewing Permission Conditions in the customer interface, when the corresponding Permission Condition Columns are not specifically configured. This setting is used as a fallback for the other Permission Condition Columns settings.'} =
        '';
    $Self->{Translation}->{'Configure the columns which are available when viewing the corresponding Permission Condition in the customer interface.'} =
        '';
    $Self->{Translation}->{'Create and manage the definitions for Configuration Items.'} = 'Δημιουργία και διαχείριση των ορισμών για τα στοιχεία διαμόρφωσης.';
    $Self->{Translation}->{'Creates Tickets for ConfigItems at specific time points.'} = 'Δημιουργεί εισιτήρια για ConfigItems σε συγκεκριμένα χρονικά σημεία.';
    $Self->{Translation}->{'Customers can see historic CI versions.'} = 'Οι πελάτες μπορούν να δουν ιστορικές εκδόσεις CI.';
    $Self->{Translation}->{'Customers have the possibility to manually switch between historic CI versions.'} =
        'Οι πελάτες έχουν τη δυνατότητα να εναλλάσσονται χειροκίνητα μεταξύ των ιστορικών εκδόσεων CI.';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".'} =
        'Προεπιλεγμένα δεδομένα που θα χρησιμοποιούνται στο χαρακτηριστικό για την οθόνη αναζήτησης στοιχείων διαμόρφωσης. Παράδειγμα: "ITSMConfigItemCreateTimePointFormat=year;ITSMConfigItemCreateTimePointStart=Last;ITSMConfigItemCreateTimePoint=2;".';
    $Self->{Translation}->{'Default data to use on attribute for config item search screen. Example: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".'} =
        'Προεπιλεγμένα δεδομένα που θα χρησιμοποιούνται στο χαρακτηριστικό για την οθόνη αναζήτησης στοιχείων διαμόρφωσης. Παράδειγμα: "ITSMConfigItemCreateTimeStartYear=2010;ITSMConfigItemCreateTimeStartMonth=10;ITSMConfigItemCreateTimeStartDay=4;ITSMConfigItemCreateTimeStopYear=2010;ITSMConfigItemCreateTimeStopMonth=11;ITSMConfigItemCreateTimeStopDay=3;".';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Ορισμός Ενεργειών όπου ένα κουμπί ρυθμίσεων είναι διαθέσιμο στο widget των συνδεδεμένων αντικειμένων (LinkObject::ViewMode = "complex"). Σημειώστε ότι αυτές οι Ενέργειες πρέπει να έχουν καταχωρίσει τα ακόλουθα αρχεία JS και CSS: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js και Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define a Template::Toolkit scheme for version strings. Only used if Version String Module is set to TemplateToolkit.'} =
        'Ορισμός ενός σχήματος Template::Toolkit για συμβολοσειρές έκδοσης. Χρησιμοποιείται μόνο αν η ενότητα Version String Module έχει οριστεί σε TemplateToolkit.';
    $Self->{Translation}->{'Define a set of conditions under which a customer is allowed to see a config item. Conditions can optionally be restricted to certain customer groups. Name is the only mandatory attribute. If no other options are given, all config items will be visible under that category.'} =
        'Ορίστε ένα σύνολο συνθηκών υπό τις οποίες επιτρέπεται σε έναν πελάτη να δει ένα στοιχείο διαμόρφωσης. Οι συνθήκες μπορούν προαιρετικά να περιοριστούν σε ορισμένες ομάδες πελατών. Το όνομα είναι το μόνο υποχρεωτικό χαρακτηριστικό. Εάν δεν δοθούν άλλες επιλογές, όλα τα στοιχεία διαμόρφωσης θα είναι ορατά στο πλαίσιο αυτής της κατηγορίας.';
    $Self->{Translation}->{'Defines Required permissions to delete ITSM configuration items using the Generic Interface.'} =
        'Καθορίζει τα απαιτούμενα δικαιώματα για τη διαγραφή στοιχείων διαμόρφωσης ITSM με χρήση της γενικής διεπαφής.';
    $Self->{Translation}->{'Defines Required permissions to get ITSM configuration items using the Generic Interface.'} =
        'Καθορίζει τα απαιτούμενα δικαιώματα για τη λήψη στοιχείων διαμόρφωσης ITSM με χρήση της γενικής διεπαφής.';
    $Self->{Translation}->{'Defines Required permissions to search ITSM configuration items using the Generic Interface.'} =
        'Καθορίζει τα απαιτούμενα δικαιώματα για την αναζήτηση στοιχείων διαμόρφωσης ITSM με χρήση της γενικής διεπαφής.';
    $Self->{Translation}->{'Defines Required permissions to set ITSM configuration items using the Generic Interface.'} =
        'Καθορίζει τα απαιτούμενα δικαιώματα για τον καθορισμό στοιχείων διαμόρφωσης ITSM με χρήση της γενικής διεπαφής.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a configuration item list.'} =
        'Ορίζει μια ενότητα επισκόπησης για την εμφάνιση της μικρής προβολής μιας λίστας στοιχείων διαμόρφωσης.';
    $Self->{Translation}->{'Defines if the link type labels must be shown in the node connections.'} =
        'Καθορίζει εάν οι ετικέτες τύπου συνδέσμου πρέπει να εμφανίζονται στις συνδέσεις κόμβων.';
    $Self->{Translation}->{'Defines regular expressions individually for each ConfigItem class to check the ConfigItem name and to show corresponding error messages.'} =
        'Ορίζει κανονικές εκφράσεις ξεχωριστά για κάθε κλάση ConfigItem για τον έλεγχο του ονόματος του ConfigItem και την εμφάνιση των αντίστοιχων μηνυμάτων σφάλματος.';
    $Self->{Translation}->{'Defines the available columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Καθορίζει τις διαθέσιμες στήλες των CI στην επισκόπηση στοιχείων διαμόρφωσης ανάλογα με την κατηγορία CI. Κάθε καταχώρηση πρέπει να αποτελείται από ένα όνομα κλάσης και έναν πίνακα διαθέσιμων πεδίων για την αντίστοιχη κλάση. Οι καταχωρίσεις δυναμικών πεδίων πρέπει να τηρούν το σχήμα DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the agent interface.'} =
        'Καθορίζει το προεπιλεγμένο χαρακτηριστικό στοιχείο παραμέτρων για την ταξινόμηση στοιχείων παραμέτρων του αποτελέσματος αναζήτησης στοιχείων παραμέτρων της διασύνδεσης πράκτορα.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of the customer interface.'} =
        'Καθορίζει το προεπιλεγμένο χαρακτηριστικό στοιχείο παραμέτρων για την ταξινόμηση στοιχείων παραμέτρων του αποτελέσματος αναζήτησης στοιχείων παραμέτρων της διεπαφής πελάτη.';
    $Self->{Translation}->{'Defines the default config item attribute for config item sorting of the config item search result of this operation.'} =
        'Καθορίζει το προεπιλεγμένο χαρακτηριστικό στοιχείο παραμέτρων για την ταξινόμηση στοιχείων παραμέτρων του αποτελέσματος αναζήτησης στοιχείων παραμέτρων αυτής της λειτουργίας.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Καθορίζει την προεπιλεγμένη σειρά στοιχείων παραμέτρων στο αποτέλεσμα αναζήτησης στοιχείων παραμέτρων της διασύνδεσης πράκτορα. Up: το παλαιότερο στην κορυφή. Κάτω: το τελευταίο στην κορυφή.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Καθορίζει την προεπιλεγμένη σειρά στοιχείων παραμέτρων στο αποτέλεσμα αναζήτησης στοιχείων παραμέτρων της διεπαφής πελάτη. Πάνω: το παλαιότερο στην κορυφή. Κάτω: το τελευταίο στην κορυφή.';
    $Self->{Translation}->{'Defines the default config item order in the config item search result of the this operation. Up: oldest on top. Down: latest on top.'} =
        'Καθορίζει την προεπιλεγμένη σειρά στοιχείων παραμέτρων στο αποτέλεσμα αναζήτησης στοιχείων παραμέτρων της λειτουργίας αυτής. Πάνω: το παλαιότερο στην κορυφή. Κάτω: το τελευταίο στην κορυφή.';
    $Self->{Translation}->{'Defines the default displayed columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        'Καθορίζει τις προεπιλεγμένες εμφανιζόμενες στήλες των CI στην επισκόπηση στοιχείων διαμόρφωσης ανάλογα με την κατηγορία CI. Κάθε καταχώρηση πρέπει να αποτελείται από ένα όνομα κλάσης και έναν πίνακα διαθέσιμων πεδίων για την αντίστοιχη κλάση. Οι καταχωρήσεις δυναμικών πεδίων πρέπει να τηρούν το σχήμα DynamicField_FieldName.';
    $Self->{Translation}->{'Defines the default relations depth to be shown.'} = 'Καθορίζει το προεπιλεγμένο βάθος σχέσεων που θα εμφανίζεται.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen.'} =
        'Καθορίζει το προεπιλεγμένο εμφανιζόμενο χαρακτηριστικό αναζήτησης στοιχείων διαμόρφωσης για την οθόνη αναζήτησης στοιχείων διαμόρφωσης.';
    $Self->{Translation}->{'Defines the default shown config item search attribute for config item search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.'} =
        'Καθορίζει το προεπιλεγμένο εμφανιζόμενο χαρακτηριστικό αναζήτησης στοιχείων διαμόρφωσης για την οθόνη αναζήτησης στοιχείων διαμόρφωσης. Παράδειγμα: "Key" πρέπει να έχει το όνομα του δυναμικού πεδίου στην προκειμένη περίπτωση \'X\', "Content" πρέπει να έχει την τιμή του δυναμικού πεδίου ανάλογα με τον τύπο του δυναμικού πεδίου, Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974- Search_DynamicField_XTimeSlotStartMonth=01- Search_DynamicField_XTimeSlotStartDay=26- Search_DynamicField_XTimeSlotStartHour=00, Search_DynamicField_XTimeSlotStartMinute=00- Search_DynamicField_XTimeSlotStartSecond=00- Search_DynamicField_XTimeSlotStopYear=2013- Search_DynamicField_XTimeSlotStopMonth=01, Search_DynamicField_XTimeSlotStopDay=26- Search_DynamicField_XTimeSlotStopHour=23- Search_DynamicField_XTimeSlotStopMinute=59- Search_DynamicField_XTimeSlotStopSecond=59,\' και ή \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.';
    $Self->{Translation}->{'Defines the default subobject of the class \'ITSMConfigItem\'.'} =
        'Ορίζει το προεπιλεγμένο υποαντικείμενο της κλάσης \'ITSMConfigItem\'.';
    $Self->{Translation}->{'Defines the disabled columns of CIs in the config item overview depending on the CI class. Each entry must consist of a class name and an array of available fields for the corresponding class. Dynamic field entries have to honor the scheme DynamicField_FieldName.'} =
        '';
    $Self->{Translation}->{'Defines the height for the rich text editor component for this screen. Enter number (pixels) or percent value (relative).'} =
        'Καθορίζει το ύψος για το στοιχείο του επεξεργαστή πλούσιου κειμένου για αυτή την οθόνη. Εισάγετε αριθμό (pixels) ή ποσοστιαία τιμή (σχετική).';
    $Self->{Translation}->{'Defines the number of rows for the CI definition editor in the admin interface.'} =
        'Καθορίζει τον αριθμό των γραμμών για τον επεξεργαστή ορισμού CI στο περιβάλλον εργασίας διαχείρισης.';
    $Self->{Translation}->{'Defines the order of incident states from high (e.g. cricital) to low (e.g. functional).'} =
        'Καθορίζει τη σειρά των καταστάσεων συμβάντων από υψηλή (π.χ. κρίσιμη) έως χαμηλή (π.χ. λειτουργική).';
    $Self->{Translation}->{'Defines the relevant deployment states where linked tickets can affect the status of a CI.'} =
        'Καθορίζει τις σχετικές καταστάσεις ανάπτυξης όπου τα συνδεδεμένα εισιτήρια μπορούν να επηρεάσουν την κατάσταση ενός CI.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItem screen.'} =
        'Καθορίζει το όριο αναζήτησης για την οθόνη AgentITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the AgentITSMConfigItemSearch screen.'} =
        'Καθορίζει το όριο αναζήτησης για την οθόνη AgentITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItem screen.'} =
        'Καθορίζει το όριο αναζήτησης για την οθόνη CustomerITSMConfigItem.';
    $Self->{Translation}->{'Defines the search limit for the CustomerITSMConfigItemSearch screen.'} =
        'Καθορίζει το όριο αναζήτησης για την οθόνη CustomerITSMConfigItemSearch.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view for all CI classes. If there is no entry, then the default columns are shown.'} =
        'Καθορίζει τις εμφανιζόμενες στήλες των CI στην πολύπλοκη προβολή του πίνακα συνδέσεων για όλες τις κατηγορίες CI. Εάν δεν υπάρχει καταχώριση, τότε εμφανίζονται οι προεπιλεγμένες στήλες.';
    $Self->{Translation}->{'Defines the shown columns of CIs in the link table complex view, depending on the CI class. Each entry must be prefixed with the class name and double colons (i.e. Computer::). There are a few CI-Attributes that common to all CIs (example for the class Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). To show individual CI-Attributes as defined in the CI-Definition, the following scheme must be used (example for the class Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. If there is no entry for a CI class, then the default columns are shown.'} =
        'Καθορίζει τις εμφανιζόμενες στήλες των CI στην πολύπλοκη προβολή του πίνακα συνδέσμων, ανάλογα με την κατηγορία CI. Κάθε εγγραφή πρέπει να έχει ως πρόθεμα το όνομα της κλάσης και διπλές άνω και κάτω τελεία (π.χ. Computer:::). Υπάρχουν μερικά CI-Attributes που είναι κοινά για όλα τα CI (παράδειγμα για την κλάση Computer: Computer::Name, Computer::CurDeplState, Computer::CreateTime). Για να εμφανιστούν μεμονωμένα CI-Attributes όπως ορίζονται στον CI-Definition, πρέπει να χρησιμοποιηθεί το ακόλουθο σχήμα (παράδειγμα για την κλάση Computer): Computer::HardDisk::1, Computer::HardDisk::1::Capacity::1, Computer::HardDisk::2, Computer::HardDisk::2::Capacity::1. Εάν δεν υπάρχει καταχώρηση για μια κλάση CI, τότε εμφανίζονται οι προεπιλεγμένες στήλες.';
    $Self->{Translation}->{'Defines which items are available for \'Action\' in third level of the ITSM Config Item ACL structure.'} =
        'Καθορίζει ποια στοιχεία είναι διαθέσιμα για "Δράση" στο τρίτο επίπεδο της δομής ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in first level of the ITSM Config Item ACL structure.'} =
        'Καθορίζει ποια στοιχεία είναι διαθέσιμα στο πρώτο επίπεδο της δομής ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which items are available in second level of the ITSM Config Item ACL structure.'} =
        'Καθορίζει ποια στοιχεία είναι διαθέσιμα στο δεύτερο επίπεδο της δομής ITSM Config Item ACL.';
    $Self->{Translation}->{'Defines which type of link (named from the ticket perspective) can affect the status of a linked CI.'} =
        'Καθορίζει ποιος τύπος σύνδεσης (με όνομα από την οπτική γωνία του εισιτηρίου) μπορεί να επηρεάσει την κατάσταση ενός συνδεδεμένου CI.';
    $Self->{Translation}->{'Defines which type of ticket can affect the status of a linked CI.'} =
        'Καθορίζει ποιος τύπος εισιτηρίου μπορεί να επηρεάσει την κατάσταση ενός συνδεδεμένου CI.';
    $Self->{Translation}->{'Definition Update'} = 'Ενημέρωση ορισμού';
    $Self->{Translation}->{'Delete Configuration Item'} = 'Διαγραφή στοιχείου διαμόρφωσης';
    $Self->{Translation}->{'DeplState'} = 'DeplState';
    $Self->{Translation}->{'Deployment State Color'} = 'Χρώμα κατάστασης ανάπτυξης';
    $Self->{Translation}->{'DeploymentState'} = 'DeploymentState';
    $Self->{Translation}->{'Duplicate'} = 'Διπλό';
    $Self->{Translation}->{'Dynamic field event module that marks config item definitions as out of sync, if containing dynamic fields change.'} =
        'Μονάδα συμβάντων δυναμικών πεδίων που επισημαίνει τους ορισμούς στοιχείων διαμόρφωσης ως μη συγχρονισμένους, εάν αλλάξουν τα δυναμικά πεδία που περιέχουν.';
    $Self->{Translation}->{'Dynamic fields shown in the additional ITSM field screen of the agent interface.'} =
        'Δυναμικά πεδία που εμφανίζονται στην οθόνη πρόσθετων πεδίων ITSM της διεπαφής του πράκτορα.';
    $Self->{Translation}->{'Dynamic fields shown in the config item overview screen of the customer interface.'} =
        'Δυναμικά πεδία που εμφανίζονται στην οθόνη επισκόπησης στοιχείων διαμόρφωσης της διεπαφής πελάτη.';
    $Self->{Translation}->{'Dynamic fields shown in the config item search screen of the agent interface.'} =
        'Δυναμικά πεδία που εμφανίζονται στην οθόνη αναζήτησης στοιχείων διαμόρφωσης του περιβάλλοντος εργασίας του πράκτορα.';
    $Self->{Translation}->{'Enables configuration item bulk action feature for the agent frontend to work on more than one configuration item at a time.'} =
        'Ενεργοποιεί τη δυνατότητα μαζικής δράσης στοιχείων διαμόρφωσης για το frontend του πράκτορα ώστε να εργάζεται σε περισσότερα από ένα στοιχεία διαμόρφωσης ταυτόχρονα.';
    $Self->{Translation}->{'Enables configuration item bulk action feature only for the listed groups.'} =
        'Η κατάσταση ανάπτυξης αυτού του στοιχείου διαμόρφωσης';
    $Self->{Translation}->{'Enables/disables the functionality to check ITSM onfiguration items for unique names. Before enabling this option you should check your system for already existing config items with duplicate names. You can do this with the console command Admin::ITSM::ConfigItem::ListDuplicates.'} =
        'Ενεργοποιεί/απενεργοποιεί τη λειτουργία ελέγχου των στοιχείων παραμέτρων ITSM για μοναδικά ονόματα. Πριν ενεργοποιήσετε αυτήν την επιλογή, θα πρέπει να ελέγξετε το σύστημά σας για ήδη υπάρχοντα στοιχεία διαμόρφωσης με διπλά ονόματα. Μπορείτε να το κάνετε αυτό με την εντολή της κονσόλας Admin::ITSM::ConfigItem::ListDuplicates.';
    $Self->{Translation}->{'Event module to set configitem-status on ticket-configitem-link.'} =
        'Ενότητα συμβάντος για να ορίσετε την κατάσταση του στοιχείου παραμετροποίησης στο σύνδεσμο ticket-configitem-link.';
    $Self->{Translation}->{'Fields of the configuration item index, used for the fulltext search. Fields are also stored, but are not mandatory for the overall functionality. Inclusion of attachments can be disabled by setting the entry to 0 or deleting it.'} =
        'Πεδία του ευρετηρίου στοιχείων διαμόρφωσης, που χρησιμοποιούνται για την αναζήτηση πλήρους κειμένου. Τα πεδία αποθηκεύονται επίσης, αλλά δεν είναι υποχρεωτικά για τη συνολική λειτουργικότητα. Η συμπερίληψη των συνημμένων μπορεί να απενεργοποιηθεί θέτοντας την καταχώρηση σε 0 ή διαγράφοντάς την.';
    $Self->{Translation}->{'Fields stored in the configuration item index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.'} =
        'Πεδία που αποθηκεύονται στο ευρετήριο στοιχείων διαμόρφωσης και χρησιμοποιούνται για άλλα πράγματα εκτός από την αναζήτηση πλήρους κειμένου. Για την πλήρη λειτουργικότητα όλα τα πεδία είναι υποχρεωτικά.';
    $Self->{Translation}->{'For every webservice (key) an array of classes (value) can be defined on which the import is restricted. For all chosen classes, or all existing classes the identifying attributes will have to be chosen in the invoker config.'} =
        'Για κάθε υπηρεσία ιστού (κλειδί) μπορεί να οριστεί ένας πίνακας κλάσεων (τιμή), στις οποίες περιορίζεται η εισαγωγή. Για όλες τις επιλεγμένες κλάσεις ή για όλες τις υπάρχουσες κλάσεις θα πρέπει να επιλεγούν τα χαρακτηριστικά αναγνώρισης στο config του invoker.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemCreate invoker layer.'} =
        '';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemFetch invoker layer.'} =
        'Εγγραφή μονάδας GenericInterface για το επίπεδο επικαλούμενου ConfigItemFetch.';
    $Self->{Translation}->{'GenericInterface module registration for the ConfigItemUpdate invoker layer.'} =
        '';
    $Self->{Translation}->{'ITSM ConfigItem'} = 'ITSM ConfigItem';
    $Self->{Translation}->{'ITSM config item overview.'} = 'Επισκόπηση στοιχείων ρυθμίσεων ITSM.';
    $Self->{Translation}->{'InciState'} = 'InciState';
    $Self->{Translation}->{'IncidentState'} = 'IncidentState';
    $Self->{Translation}->{'Includes deployment states in the config item search of the customer interface.'} =
        'Περιλαμβάνει καταστάσεις ανάπτυξης στην αναζήτηση στοιχείων διαμόρφωσης της διεπαφής πελάτη.';
    $Self->{Translation}->{'Includes incident states in the config item search of the customer interface.'} =
        'Περιλαμβάνει καταστάσεις συμβάντων στην αναζήτηση στοιχείων διαμόρφωσης της διεπαφής πελάτη.';
    $Self->{Translation}->{'License accounting configuration item event module.'} = '';
    $Self->{Translation}->{'Maximum number of config items to be displayed in the result of this operation.'} =
        'Μέγιστος αριθμός στοιχείων διαμόρφωσης που θα εμφανίζονται στο αποτέλεσμα αυτής της λειτουργίας.';
    $Self->{Translation}->{'Module to check the group responsible for a class.'} = 'Ενότητα για τον έλεγχο της ομάδας που είναι υπεύθυνη για μια τάξη.';
    $Self->{Translation}->{'Module to check the group responsible for a configuration item.'} =
        'Ενότητα για τον έλεγχο της ομάδας που είναι υπεύθυνη για ένα στοιχείο διαμόρφωσης.';
    $Self->{Translation}->{'Module to generate ITSM config item statistics.'} = 'Ενότητα για τη δημιουργία στατιστικών στοιχείων διαμόρφωσης ITSM.';
    $Self->{Translation}->{'Name Module'} = 'Όνομα Ενότητα';
    $Self->{Translation}->{'Number Module'} = 'Ενότητα αριθμού';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the agent interface.'} =
        'Αριθμός στοιχείων διαμόρφωσης που θα εμφανίζονται σε κάθε σελίδα ενός αποτελέσματος αναζήτησης στο περιβάλλον εργασίας του πράκτορα.';
    $Self->{Translation}->{'Number of config items to be displayed in each page of a search result in the customer interface.'} =
        'Αριθμός στοιχείων διαμόρφωσης που θα εμφανίζονται σε κάθε σελίδα ενός αποτελέσματος αναζήτησης στο περιβάλλον εργασίας του πελάτη.';
    $Self->{Translation}->{'Objects to search for, how many entries and which attributs to show. ConfigItem attributes have to explicitly be stored via Elasticsearch.'} =
        'Αντικείμενα για τα οποία θα γίνει αναζήτηση, πόσες καταχωρήσεις και ποια χαρακτηριστικά θα εμφανιστούν. Τα χαρακτηριστικά ConfigItem πρέπει να αποθηκεύονται ρητά μέσω του Elasticsearch.';
    $Self->{Translation}->{'Overview.'} = 'Επισκόπηση.';
    $Self->{Translation}->{'Parameters for the categories for config item classes in the preferences view of the agent interface.'} =
        'Παράμετροι για τις κατηγορίες των κλάσεων στοιχείων διαμόρφωσης στην προβολή προτιμήσεων της διεπαφής του πράκτορα.';
    $Self->{Translation}->{'Parameters for the column filters of the small config item overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.'} =
        'Παράμετροι για τα φίλτρα στήλης της επισκόπησης στοιχείων μικρής διαμόρφωσης. Σημείωση: η ρύθμιση \'Active\' σε 0 θα εμποδίσει μόνο τους πράκτορες να επεξεργάζονται τις ρυθμίσεις αυτής της ομάδας στις προσωπικές τους προτιμήσεις, αλλά θα επιτρέψει στους διαχειριστές να επεξεργάζονται τις ρυθμίσεις για λογαριασμό άλλου χρήστη. Χρησιμοποιήστε το \'PreferenceGroup\' για να ελέγξετε σε ποια περιοχή θα εμφανίζονται αυτές οι ρυθμίσεις στο περιβάλλον εργασίας χρήστη.';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries per config item class shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "ConfigItemKey" is used to specify which reference field is used for a ConfigItem class (Key=Class, Value=DynamicFieldName).'} =
        '';
    $Self->{Translation}->{'Parameters for the dashboard backend of the customer company config item overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "ConfigItemKey" is used to specify which reference field is used for a ConfigItem class (Key=Class, Value=DynamicFieldName).'} =
        '';
    $Self->{Translation}->{'Parameters for the deployment states color in the preferences view of the agent interface.'} =
        'Παράμετροι για το χρώμα των καταστάσεων ανάπτυξης στην προβολή προτιμήσεων της διεπαφής του πράκτορα.';
    $Self->{Translation}->{'Parameters for the deployment states in the preferences view of the agent interface.'} =
        'Παράμετροι για τις καταστάσεις ανάπτυξης στην προβολή προτιμήσεων της διεπαφής του πράκτορα.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Παράμετροι για τις ομάδες δικαιωμάτων του παραδείγματος των γενικών χαρακτηριστικών καταλόγου.';
    $Self->{Translation}->{'Parameters for the name module for config item classes in the preferences view of the agent interface.'} =
        'Παράμετροι για τη μονάδα ονόματος για τις κλάσεις στοιχείων διαμόρφωσης στην προβολή προτιμήσεων της διεπαφής πράκτορα.';
    $Self->{Translation}->{'Parameters for the number module for config item classes in the preferences view of the agent interface.'} =
        'Παράμετροι για τη μονάδα αριθμού για τις κλάσεις στοιχείων διαμόρφωσης στην προβολή προτιμήσεων της διεπαφής πράκτορα.';
    $Self->{Translation}->{'Parameters for the pages (in which the configuration items are shown).'} =
        'Παράμετροι για τις σελίδες (στις οποίες εμφανίζονται τα στοιχεία διαμόρφωσης).';
    $Self->{Translation}->{'Parameters for the version string module for config item classes in the preferences view of the agent interface.'} =
        'Παράμετροι για τη μονάδα συμβολοσειράς έκδοσης για τις κλάσεις στοιχείων διαμόρφωσης στην προβολή προτιμήσεων της διεπαφής του πράκτορα.';
    $Self->{Translation}->{'Parameters for the version string template toolkit module for config item classes in the preferences view of the agent interface.'} =
        'Παράμετροι για την ενότητα εργαλειοθήκης προτύπου συμβολοσειράς έκδοσης για τις κλάσεις στοιχείων διαμόρφωσης στην προβολή προτιμήσεων της διεπαφής του πράκτορα.';
    $Self->{Translation}->{'Parameters for the version trigger for config item classes in the preferences view of the agent interface.'} =
        'Παράμετροι για την ενεργοποίηση έκδοσης για τις κλάσεις στοιχείων διαμόρφωσης στην προβολή προτιμήσεων της διεπαφής του πράκτορα.';
    $Self->{Translation}->{'Performs the configured action for each event (as an Invoker) for each configured Webservice.'} =
        'Εκτελεί τη ρυθμισμένη ενέργεια για κάθε συμβάν (ως Invoker) για κάθε ρυθμισμένη υπηρεσία Webservice.';
    $Self->{Translation}->{'Permission Group'} = 'Ομάδα αδειών';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item attachment action in the agent interface.'} =
        'Απαιτούμενα δικαιώματα για τη χρήση της ενέργειας προσάρτησης στοιχείου διαμόρφωσης ITSM στο περιβάλλον εργασίας του πράκτορα.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item screen in the agent interface.'} =
        'Απαιτούμενα δικαιώματα για τη χρήση της οθόνης στοιχείων διαμόρφωσης ITSM στο περιβάλλον εργασίας του πράκτορα.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the agent interface.'} =
        'Απαιτούμενα δικαιώματα για τη χρήση της οθόνης αναζήτησης στοιχείων διαμόρφωσης ITSM στο περιβάλλον εργασίας του πράκτορα.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item search screen in the customer interface.'} =
        'Απαιτούμενα δικαιώματα για τη χρήση της οθόνης αναζήτησης στοιχείων διαμόρφωσης ITSM στη διεπαφή πελάτη.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item tree view screen in the agent interface.'} =
        'Απαιτούμενα δικαιώματα για τη χρήση της οθόνης δενδρικής προβολής στοιχείων διαμόρφωσης ITSM στο περιβάλλον εργασίας του πράκτορα.';
    $Self->{Translation}->{'Required permissions to use the ITSM configuration item zoom screen in the agent interface.'} =
        'Απαιτούμενα δικαιώματα για τη χρήση της οθόνης μεγέθυνσης στοιχείων διαμόρφωσης ITSM στη διεπαφή του πράκτορα.';
    $Self->{Translation}->{'Required permissions to use the add ITSM configuration item screen in the agent interface.'} =
        'Απαιτούμενα δικαιώματα για τη χρήση της οθόνης προσθήκης στοιχείου διαμόρφωσης ITSM στο περιβάλλον εργασίας του πράκτορα.';
    $Self->{Translation}->{'Required permissions to use the bulk ITSM configuration item screen in the agent interface.'} =
        'Απαιτούμενα δικαιώματα για τη χρήση της οθόνης μαζικών στοιχείων διαμόρφωσης ITSM στο περιβάλλον εργασίας του πράκτορα.';
    $Self->{Translation}->{'Required permissions to use the edit ITSM configuration item screen in the agent interface.'} =
        'Απαιτούμενα δικαιώματα για τη χρήση της οθόνης επεξεργασίας στοιχείων διαμόρφωσης ITSM στη διεπαφή του πράκτορα.';
    $Self->{Translation}->{'Required permissions to use the history ITSM configuration item screen in the agent interface.'} =
        'Απαιτούμενα δικαιώματα για τη χρήση της οθόνης στοιχείων διαμόρφωσης ιστορικού ITSM στο περιβάλλον εργασίας του πράκτορα.';
    $Self->{Translation}->{'Required permissions to use the print ITSM configuration item screen in the agent interface.'} =
        'Απαιτούμενα δικαιώματα για τη χρήση της οθόνης print ITSM configuration item στο περιβάλλον εργασίας του πράκτορα.';
    $Self->{Translation}->{'Required privileges to delete config items.'} = 'Απαιτούμενα προνόμια για τη διαγραφή στοιχείων ρυθμίσεων.';
    $Self->{Translation}->{'Search config items.'} = 'Αναζήτηση στοιχείων διαμόρφωσης.';
    $Self->{Translation}->{'Set the incident state of a CI automatically when a Ticket is Linked to a CI.'} =
        'Ορίστε αυτόματα την κατάσταση συμβάντος ενός CI όταν ένα Ticket συνδέεται με ένα CI.';
    $Self->{Translation}->{'Sets the deployment state in the configuration item bulk screen of the agent interface.'} =
        'Ορίζει την κατάσταση ανάπτυξης στην οθόνη μαζικής προβολής στοιχείων διαμόρφωσης της διασύνδεσης του πράκτορα.';
    $Self->{Translation}->{'Sets the incident state in the configuration item bulk screen of the agent interface.'} =
        'Ορίζει την κατάσταση συμβάντος στην οθόνη μαζικής προβολής στοιχείων διαμόρφωσης της διεπαφής πράκτορα.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a configuration item with another object in the config item zoom view of the agent interface.'} =
        'προπαραγωγική';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the configuration item overview of the agent interface.'} =
        'Εμφανίζει έναν σύνδεσμο στο μενού για πρόσβαση στο ιστορικό ενός στοιχείου διαμόρφωσης στην επισκόπηση στοιχείων διαμόρφωσης του περιβάλλοντος εργασίας του πράκτορα.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a configuration item in the its zoom view of the agent interface.'} =
        'Εμφανίζει έναν σύνδεσμο στο μενού για πρόσβαση στο ιστορικό ενός στοιχείου διαμόρφωσης στην προβολή μεγέθυνσης του περιβάλλοντος εργασίας του πράκτορα.';
    $Self->{Translation}->{'Shows a link in the menu to delete a configuration item in its zoom view of the agent interface.'} =
        'Εμφανίζει έναν σύνδεσμο στο μενού για τη διαγραφή ενός στοιχείου διαμόρφωσης στην προβολή μεγέθυνσης της διεπαφής του πράκτορα.';
    $Self->{Translation}->{'Shows a link in the menu to display the configuration item links as a Tree View.'} =
        'Εμφανίζει έναν σύνδεσμο στο μενού για την εμφάνιση των συνδέσμων των στοιχείων διαμόρφωσης ως δενδρική προβολή.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the configuration item overview of the agent interface.'} =
        'Εμφανίζει έναν σύνδεσμο στο μενού για την αντιγραφή ενός στοιχείου διαμόρφωσης στην επισκόπηση στοιχείων διαμόρφωσης του περιβάλλοντος εργασίας του πράκτορα.';
    $Self->{Translation}->{'Shows a link in the menu to duplicate a configuration item in the its zoom view of the agent interface.'} =
        'Εμφανίζει έναν σύνδεσμο στο μενού για την αντιγραφή ενός στοιχείου διαμόρφωσης στην προβολή μεγέθυνσης του περιβάλλοντος εργασίας του πράκτορα.';
    $Self->{Translation}->{'Shows a link in the menu to edit a configuration item in the its zoom view of the agent interface.'} =
        'Εμφανίζει έναν σύνδεσμο στο μενού για την επεξεργασία ενός στοιχείου διαμόρφωσης στην προβολή μεγέθυνσης του περιβάλλοντος εργασίας του πράκτορα.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the configuration item zoom view of the agent interface.'} =
        'Εμφανίζει έναν σύνδεσμο στο μενού για να επιστρέψετε στην προβολή μεγέθυνσης του στοιχείου διαμόρφωσης της διεπαφής του πράκτορα.';
    $Self->{Translation}->{'Shows a link in the menu to print a configuration item in the its zoom view of the agent interface.'} =
        'Εμφανίζει έναν σύνδεσμο στο μενού για την εκτύπωση ενός στοιχείου διαμόρφωσης στην προβολή μεγέθυνσης του περιβάλλοντος εργασίας του πράκτορα.';
    $Self->{Translation}->{'Shows a link in the menu to zoom into a configuration item in the configuration item overview of the agent interface.'} =
        'Εμφανίζει έναν σύνδεσμο στο μενού για μεγέθυνση σε ένα στοιχείο διαμόρφωσης στην επισκόπηση στοιχείων διαμόρφωσης του περιβάλλοντος εργασίας του πράκτορα.';
    $Self->{Translation}->{'Shows the config item history (reverse ordered) in the agent interface.'} =
        'Εμφανίζει το ιστορικό στοιχείων διαμόρφωσης (αντίστροφη σειρά) στο περιβάλλον εργασίας του πράκτορα.';
    $Self->{Translation}->{'The default category which is shown, if none is selected.'} = 'Η προεπιλεγμένη κατηγορία που εμφανίζεται, εάν δεν έχει επιλεγεί καμία.';
    $Self->{Translation}->{'The identifier for a configuration item, e.g. ConfigItem#, MyConfigItem#. The default is ConfigItem#.'} =
        'Το αναγνωριστικό για ένα στοιχείο διαμόρφωσης, π.χ. ConfigItem#, MyConfigItem#. Η προεπιλογή είναι ConfigItem#.';
    $Self->{Translation}->{'Triggers ConfigItemFetch invoker automatically.'} = 'Προκαλεί αυτόματα την επίκληση ConfigItemFetch.';
    $Self->{Translation}->{'Version String Expression'} = 'Έκδοση String Expression';
    $Self->{Translation}->{'Version String Module'} = 'Έκδοση String Module';
    $Self->{Translation}->{'Version Trigger'} = 'Σκανδάλη έκδοσης';
    $Self->{Translation}->{'Whether fields should be automatically filled (1), and in that case also be hidden from ticket formulars (2).'} =
        '';
    $Self->{Translation}->{'Whether the execution of ConfigItemACL can be avoided by checking cached field dependencies. This can improve loading times of formulars, but has to be disabled, if ACLModules are to be used for ITSMConfigItem- and Form-ReturnTypes.'} =
        'Εάν η εκτέλεση του ConfigItemACL μπορεί να αποφευχθεί με τον έλεγχο των εξαρτήσεων των πεδίων που έχουν αποθηκευτεί στην προσωρινή μνήμη. Αυτό μπορεί να βελτιώσει τους χρόνους φόρτωσης των φορμών, αλλά πρέπει να απενεργοποιηθεί, εάν πρόκειται να χρησιμοποιηθούν ACLModules για ITSMConfigItem- και Form-ReturnTypes.';
    $Self->{Translation}->{'Which general information is shown in the header.'} = 'Ποιες γενικές πληροφορίες εμφανίζονται στην επικεφαλίδα.';
    $Self->{Translation}->{'class'} = 'κατηγορία';
    $Self->{Translation}->{'global'} = 'παγκόσμιο';
    $Self->{Translation}->{'postproductive'} = 'μεταπαραγωγική';
    $Self->{Translation}->{'preproductive'} = 'προπαραγωγική';
    $Self->{Translation}->{'productive'} = 'παραγωγικό';

    # Ready to adopt classes: IT-Servicemanagement-11_0_3
    $Self->{Translation}->{'10U: 17.5 inches (44.45 cm)'} = '10U: 44,45 cm (17,5 ίντσες)';
    $Self->{Translation}->{'12U: 21 inches (53.34 cm)'} = '12U: 21 ίντσες (53,34 cm)';
    $Self->{Translation}->{'15U: 26.25 inches (66.68 cm)'} = '15U: 66,68 cm (26,25 ίντσες)';
    $Self->{Translation}->{'18U: 31.5 inches (80.01 cm)'} = '18U: 80,01 cm (31,5 ίντσες)';
    $Self->{Translation}->{'19-inch Rack'} = 'Ράφι 19 ιντσών';
    $Self->{Translation}->{'1U: 1.75 inches (4.45 cm)'} = '1U: 4,45 cm (1,75 ίντσες)';
    $Self->{Translation}->{'20U: 35 inches (88.9 cm)'} = '20U: 88,9 cm (35 ίντσες)';
    $Self->{Translation}->{'21-inch Rack'} = 'Ράφι 21 ιντσών';
    $Self->{Translation}->{'22U: 38.5 inches (97.79 cm)'} = '22U: 38,5 ίντσες (97,79 cm)';
    $Self->{Translation}->{'23-inch Rack'} = 'Ράφι 23 ιντσών';
    $Self->{Translation}->{'23.6 inches (600 mm)'} = '23,6 ίντσες (600 mm)';
    $Self->{Translation}->{'24U: 42 inches (106.68 cm)'} = '24U: 42 ίντσες (106,68 cm)';
    $Self->{Translation}->{'27U: 47.25 inches (120.02 cm)'} = '27U: 47,25 ίντσες (120,02 cm)';
    $Self->{Translation}->{'2U: 3.5 inches (8.89 cm)'} = '2U: 8,89 cm (3,5 ίντσες)';
    $Self->{Translation}->{'30U: 52.5 inches (133.35 cm)'} = '30U: 52,5 ίντσες (133,35 cm)';
    $Self->{Translation}->{'31.5 inches (800 mm)'} = '31,5 ίντσες (800 mm)';
    $Self->{Translation}->{'33U: 57.75 inches (146.68 cm)'} = '33U: 57,75 ίντσες (146,68 cm)';
    $Self->{Translation}->{'35.4 inches (900 mm)'} = '35,4 ίντσες (900 mm)';
    $Self->{Translation}->{'36U: 63 inches (160.02 cm)'} = '36U: 160,02 cm (63 ίντσες)';
    $Self->{Translation}->{'39.4 inches (1000 mm)'} = '39,4 ίντσες (1000 mm)';
    $Self->{Translation}->{'39U: 68.25 inches (173.35 cm)'} = '39U: 173,35 cm (68,25 ίντσες)';
    $Self->{Translation}->{'3U: 5.25 inches (13.34 cm)'} = '3U: 13,34 cm (5,25 ίντσες)';
    $Self->{Translation}->{'42U: 73.5 inches (186.69 cm)'} = '42U: 186,69 cm (73,5 ίντσες)';
    $Self->{Translation}->{'43.3 inches (1100 mm):'} = '43,3 ίντσες (1100 mm):';
    $Self->{Translation}->{'45U: 78.75 inches (200.02 cm)'} = '45U: 200,02 cm (78,75 ίντσες)';
    $Self->{Translation}->{'47.2 inches (1200 mm)'} = '47,2 ίντσες (1200 mm)';
    $Self->{Translation}->{'48U: 84 inches (213.36 cm)'} = '48U: 213,36 cm (84 ίντσες)';
    $Self->{Translation}->{'4U: 7 inches (17.78 cm)'} = '4U: 7 ίντσες (17,78 cm)';
    $Self->{Translation}->{'5U: 8.75 inches (22.23 cm)'} = '5U: 22,23 cm (8,75 ίντσες)';
    $Self->{Translation}->{'6U: 10.5 inches (26.67 cm)'} = '6U: 26,67 cm (10,5 ίντσες)';
    $Self->{Translation}->{'7U: 12.25 inches (31.12 cm)'} = '7U: 31,12 cm (12,25 ίντσες)';
    $Self->{Translation}->{'8U: 14 inches (35.56 cm)'} = '8U: 14 ίντσες (35,56 cm)';
    $Self->{Translation}->{'9U: 15.75 inches (40.01 cm)'} = '9U: 40,01 cm (15,75 ίντσες)';
    $Self->{Translation}->{'AGPL (Affero General Public License)'} = '';
    $Self->{Translation}->{'Accounting'} = 'Λογιστική';
    $Self->{Translation}->{'Accounting Information'} = '';
    $Self->{Translation}->{'Address Allocation'} = 'Κατανομή διευθύνσεων';
    $Self->{Translation}->{'Administrator'} = 'Διαχειριστής';
    $Self->{Translation}->{'Analog Phone'} = 'Αναλογικό τηλέφωνο';
    $Self->{Translation}->{'Apache Lizenz'} = '';
    $Self->{Translation}->{'Appliance Type'} = 'Τύπος συσκευής';
    $Self->{Translation}->{'BSD Lizenz (Berkeley Software Distribution License)'} = '';
    $Self->{Translation}->{'Battery Capacity (Ah)'} = 'Χωρητικότητα μπαταρίας (Ah)';
    $Self->{Translation}->{'Battery Type'} = 'Τύπος μπαταρίας';
    $Self->{Translation}->{'Building'} = 'Κτίριο';
    $Self->{Translation}->{'Bus Interface'} = 'Διασύνδεση διαύλου';
    $Self->{Translation}->{'CC0 (Creative Commons Zero)'} = '';
    $Self->{Translation}->{'CIDR'} = 'CIDR';
    $Self->{Translation}->{'CPU'} = 'CPU';
    $Self->{Translation}->{'CPU Class'} = 'Κατηγορία CPU';
    $Self->{Translation}->{'Capacity (GB)'} = 'Χωρητικότητα (GB)';
    $Self->{Translation}->{'Capacity per graphics card'} = 'Χωρητικότητα ανά κάρτα γραφικών';
    $Self->{Translation}->{'Card Number'} = 'Αριθμός κάρτας';
    $Self->{Translation}->{'Card Reader'} = 'Αναγνώστης καρτών';
    $Self->{Translation}->{'Card Type'} = 'Τύπος κάρτας';
    $Self->{Translation}->{'Client Certificates'} = 'Πιστοποιητικά πελατών';
    $Self->{Translation}->{'Client Software'} = 'Λογισμικό πελάτη';
    $Self->{Translation}->{'Client category'} = 'Κατηγορία πελάτη';
    $Self->{Translation}->{'Clockrate'} = 'Ρυθμός ρολογιού';
    $Self->{Translation}->{'Clockspeed'} = 'Ταχύτητα ρολογιού';
    $Self->{Translation}->{'Code Signing Certificates'} = 'Πιστοποιητικά υπογραφής κώδικα';
    $Self->{Translation}->{'Conference Phone'} = 'Τηλέφωνο συνδιάσκεψης';
    $Self->{Translation}->{'Consulting Agreement'} = 'Συμβουλευτική συμφωνία';
    $Self->{Translation}->{'Contact'} = 'Επικοινωνία';
    $Self->{Translation}->{'Contact Distributor'} = 'Επικοινωνήστε με τον διανομέα';
    $Self->{Translation}->{'Container Management'} = 'Διαχείριση εμπορευματοκιβωτίων';
    $Self->{Translation}->{'Contract'} = 'Σύμβαση';
    $Self->{Translation}->{'Contract Type'} = 'Τύπος σύμβασης';
    $Self->{Translation}->{'Contract period from'} = 'Περίοδος σύμβασης από';
    $Self->{Translation}->{'Contract period until'} = 'Περίοδος σύμβασης έως';
    $Self->{Translation}->{'Cordless Phone (DECT Phone)'} = 'Ασύρματο τηλέφωνο (τηλέφωνο DECT)';
    $Self->{Translation}->{'Cost unit'} = 'Μονάδα κόστους';
    $Self->{Translation}->{'Count of licenses'} = 'Αριθμός αδειών';
    $Self->{Translation}->{'Creation Date'} = 'Ημερομηνία δημιουργίας';
    $Self->{Translation}->{'Creative Commons'} = '';
    $Self->{Translation}->{'Custom Rack'} = 'Προσαρμοσμένο ράφι';
    $Self->{Translation}->{'DHCP'} = 'DHCP';
    $Self->{Translation}->{'DHCP Reserved'} = 'DHCP Κρατημένο';
    $Self->{Translation}->{'DNS-Server'} = 'DNS-Server';
    $Self->{Translation}->{'DVI'} = 'DVI';
    $Self->{Translation}->{'Date of Invoice'} = 'Ημερομηνία του τιμολογίου';
    $Self->{Translation}->{'Date of Order'} = 'Ημερομηνία παραγγελίας';
    $Self->{Translation}->{'Date of Warranty'} = 'Ημερομηνία χορήγησης εγγύησης';
    $Self->{Translation}->{'Date of release'} = 'Ημερομηνία κυκλοφορίας';
    $Self->{Translation}->{'Desktop'} = 'Επιτραπέζια επιφάνεια εργασίας';
    $Self->{Translation}->{'DisplayPort'} = 'DisplayPort';
    $Self->{Translation}->{'Document Signing Certificates'} = 'Πιστοποιητικά υπογραφής εγγράφων';
    $Self->{Translation}->{'EPL (Eclipse Public License)'} = '';
    $Self->{Translation}->{'ETSI Rack'} = 'Ράφι ETSI';
    $Self->{Translation}->{'Email Certificates (S/MIME Certificates)'} = 'Πιστοποιητικά ηλεκτρονικού ταχυδρομείου (πιστοποιητικά S/MIME)';
    $Self->{Translation}->{'Embedded SIM (eSIM)'} = '';
    $Self->{Translation}->{'Employment Contract'} = 'Σύμβαση εργασίας';
    $Self->{Translation}->{'End IP Address'} = 'Διεύθυνση IP τέλους';
    $Self->{Translation}->{'End of support'} = 'Τέλος της στήριξης';
    $Self->{Translation}->{'Expiry Date'} = 'Ημερομηνία λήξης';
    $Self->{Translation}->{'External Hard Drive'} = 'Εξωτερικός σκληρός δίσκος';
    $Self->{Translation}->{'Firewall'} = 'Τείχος προστασίας';
    $Self->{Translation}->{'Firmware'} = 'Firmware';
    $Self->{Translation}->{'Flywheel Energy Storage'} = 'Αποθήκευση ενέργειας με ιπτάμενο τροχό';
    $Self->{Translation}->{'Form Factor'} = 'Παράγοντας μορφής';
    $Self->{Translation}->{'Franchise Agreement'} = 'Συμφωνία Franchise';
    $Self->{Translation}->{'Freeware'} = 'Freeware';
    $Self->{Translation}->{'GPL (General Public License)'} = '';
    $Self->{Translation}->{'General Information'} = 'Γενικές πληροφορίες';
    $Self->{Translation}->{'Graphics Cards'} = 'Κάρτες γραφικών';
    $Self->{Translation}->{'Graphics card'} = 'Κάρτα γραφικών';
    $Self->{Translation}->{'HDMI'} = 'HDMI';
    $Self->{Translation}->{'Hardware'} = 'Υλικό';
    $Self->{Translation}->{'Hardware Model'} = 'Μοντέλο υλικού';
    $Self->{Translation}->{'Hardware Weight'} = 'Βάρος υλικού';
    $Self->{Translation}->{'Headset'} = 'Ακουστικά';
    $Self->{Translation}->{'IP Protocol'} = 'Πρωτόκολλο IP';
    $Self->{Translation}->{'Identity and Access Management (IAM)'} = 'Διαχείριση ταυτότητας και πρόσβασης (IAM)';
    $Self->{Translation}->{'Inventory Number'} = 'Αριθμός απογραφής';
    $Self->{Translation}->{'Inverstment costs'} = 'Κόστος μετατροπής';
    $Self->{Translation}->{'Invoice Number'} = 'Αριθμός τιμολογίου';
    $Self->{Translation}->{'Keyboard'} = 'Πληκτρολόγιο';
    $Self->{Translation}->{'LCD Monitor (Liquid Crystal Display)'} = 'Οθόνη LCD (Οθόνη υγρών κρυστάλλων)';
    $Self->{Translation}->{'LED Monitor (Light Emitting Diode)'} = 'Οθόνη LED (δίοδος εκπομπής φωτός)';
    $Self->{Translation}->{'LGPL (Lesser General Public License)'} = '';
    $Self->{Translation}->{'Landline Phone'} = 'Σταθερό τηλέφωνο';
    $Self->{Translation}->{'Laptop'} = 'Φορητός υπολογιστής';
    $Self->{Translation}->{'Latitude'} = 'Γεωγραφικό πλάτος';
    $Self->{Translation}->{'Layer 1: Physical Layer'} = 'Στρώμα 1: Φυσικό στρώμα';
    $Self->{Translation}->{'Layer 2: Data Link Layer'} = 'Στρώμα 2: Στρώμα ζεύξης δεδομένων';
    $Self->{Translation}->{'Layer 3: Network Layer'} = 'Στρώμα 3: Στρώμα δικτύου';
    $Self->{Translation}->{'Layer 3: Network Layer (Supernet)'} = 'Επίπεδο 3: Επίπεδο δικτύου (Supernet)';
    $Self->{Translation}->{'Layer 4: Transport Layer'} = 'Στρώμα 4: Στρώμα μεταφοράς';
    $Self->{Translation}->{'Layer 5: Session Layer'} = 'Στρώμα 5: Στρώμα συνόδου';
    $Self->{Translation}->{'Layer 6: Presentation Layer'} = 'Στρώμα 6: Στρώμα παρουσίασης';
    $Self->{Translation}->{'Layer 7: Application Layer'} = 'Στρώμα 7: Στρώμα εφαρμογής';
    $Self->{Translation}->{'Lease Agreement'} = 'Συμφωνία μίσθωσης';
    $Self->{Translation}->{'License Agreement'} = 'Συμφωνία άδειας χρήσης';
    $Self->{Translation}->{'License Count'} = '';
    $Self->{Translation}->{'License Key'} = 'Κλειδί άδειας χρήσης';
    $Self->{Translation}->{'License Type'} = 'Τύπος άδειας';
    $Self->{Translation}->{'License period from'} = 'Περίοδος άδειας από';
    $Self->{Translation}->{'License period until'} = 'Περίοδος άδειας μέχρι';
    $Self->{Translation}->{'Lithium Iron Phosphate (LiFePO4) Battery'} = 'Μπαταρία φωσφορικού σιδήρου λιθίου (LiFePO4)';
    $Self->{Translation}->{'Lithium-Ion (Li-ion) Battery'} = 'Μπαταρία ιόντων λιθίου (Li-ion)';
    $Self->{Translation}->{'Loan Agreement'} = 'Σύμβαση δανείου';
    $Self->{Translation}->{'Located in'} = 'Βρίσκεται στην';
    $Self->{Translation}->{'Longitude'} = 'Γεωγραφικό μήκος';
    $Self->{Translation}->{'MIT Lizenz'} = '';
    $Self->{Translation}->{'MPL (Mozilla Public License)'} = '';
    $Self->{Translation}->{'Manufacturer'} = 'Κατασκευαστής';
    $Self->{Translation}->{'Maximum Load Capacity (W)'} = 'Μέγιστη χωρητικότητα φορτίου (W)';
    $Self->{Translation}->{'Memory'} = 'Μνήμη';
    $Self->{Translation}->{'Memory Type'} = 'Τύπος μνήμης';
    $Self->{Translation}->{'Micro SIM'} = '';
    $Self->{Translation}->{'Mini-Rack'} = 'Mini-Rack';
    $Self->{Translation}->{'Mobile Number'} = 'Αριθμός κινητού τηλεφώνου';
    $Self->{Translation}->{'Mobile/Embedded'} = 'Κινητό/ενσωματωμένο';
    $Self->{Translation}->{'Model'} = 'Μοντέλο';
    $Self->{Translation}->{'Model Description'} = 'Περιγραφή μοντέλου';
    $Self->{Translation}->{'Monitor Resolution'} = 'Ανάλυση οθόνης';
    $Self->{Translation}->{'Monitor Size'} = 'Μέγεθος οθόνης';
    $Self->{Translation}->{'Mouse'} = 'Ποντίκι';
    $Self->{Translation}->{'Nano SIM'} = '';
    $Self->{Translation}->{'Network'} = 'Δίκτυο';
    $Self->{Translation}->{'Network Info'} = 'Πληροφορίες δικτύου';
    $Self->{Translation}->{'Network Information'} = 'Πληροφορίες δικτύου';
    $Self->{Translation}->{'Network Layer'} = 'Επίπεδο δικτύου';
    $Self->{Translation}->{'Nickel-Cadmium (NiCd) Battery'} = 'Μπαταρία νικελίου-καδμίου (NiCd)';
    $Self->{Translation}->{'Nickel-Metal Hydride (NiMH) Battery'} = 'Μπαταρία νικελίου-μεταλλικού υδριδίου (NiMH)';
    $Self->{Translation}->{'Non-Disclosure Agreement (NDA)'} = 'Συμφωνία μη αποκάλυψης (NDA)';
    $Self->{Translation}->{'Notebook'} = 'Σημειωματάριο';
    $Self->{Translation}->{'Number of CPUs'} = 'Αριθμός CPUs';
    $Self->{Translation}->{'Number of RAM modules'} = 'Αριθμός μονάδων RAM';
    $Self->{Translation}->{'Number of graphics cards'} = 'Αριθμός καρτών γραφικών';
    $Self->{Translation}->{'OLED Monitor (Organic Light Emitting Diode)'} = 'Οθόνη OLED (οργανική δίοδος εκπομπής φωτός)';
    $Self->{Translation}->{'Operating costs'} = 'Λειτουργικό κόστος';
    $Self->{Translation}->{'Order Number'} = 'Αριθμός παραγγελίας';
    $Self->{Translation}->{'Other'} = 'Άλλα';
    $Self->{Translation}->{'Outputs'} = 'Έξοδοι';
    $Self->{Translation}->{'PIN'} = 'PIN';
    $Self->{Translation}->{'PIN 2'} = 'PIN 2';
    $Self->{Translation}->{'PUK'} = 'PUK';
    $Self->{Translation}->{'PUK 2'} = 'PUK 2';
    $Self->{Translation}->{'Partnership Agreement'} = 'Συμφωνία εταιρικής σχέσης';
    $Self->{Translation}->{'Perpetual licenses'} = '';
    $Self->{Translation}->{'Phone / VoIP'} = '';
    $Self->{Translation}->{'Phone Number'} = 'Αριθμός τηλεφώνου';
    $Self->{Translation}->{'Phone Type'} = 'Τύπος τηλεφώνου';
    $Self->{Translation}->{'Physical Cores'} = 'Φυσικοί πυρήνες';
    $Self->{Translation}->{'Power Delivery'} = 'Παράδοση ισχύος';
    $Self->{Translation}->{'Public Domain'} = '';
    $Self->{Translation}->{'Purchased at'} = 'Αγοράστηκε στο';
    $Self->{Translation}->{'Rack Depth'} = 'Βάθος ραφιού';
    $Self->{Translation}->{'Rack Units (U)'} = 'Μονάδες Rack (U)';
    $Self->{Translation}->{'Room'} = 'Δωμάτιο';
    $Self->{Translation}->{'SIM Card'} = 'Κάρτα SIM';
    $Self->{Translation}->{'SSL/TLS Certificates'} = 'Πιστοποιητικά SSL/TLS';
    $Self->{Translation}->{'Sales Contract'} = 'Σύμβαση πώλησης';
    $Self->{Translation}->{'Satellite Phone'} = 'Δορυφορικό τηλέφωνο';
    $Self->{Translation}->{'Sealed Lead-Acid (SLA) Battery'} = 'Σφραγισμένη μπαταρία μολύβδου-οξέος (SLA)';
    $Self->{Translation}->{'Seat licenses'} = '';
    $Self->{Translation}->{'Serialnumber'} = 'Αύξων αριθμός';
    $Self->{Translation}->{'Server Software'} = 'Λογισμικό διακομιστή';
    $Self->{Translation}->{'Service Agreement'} = 'Συμφωνία παροχής υπηρεσιών';
    $Self->{Translation}->{'Service Tag'} = 'Ετικέτα υπηρεσίας';
    $Self->{Translation}->{'Shareware'} = '';
    $Self->{Translation}->{'Socket Type'} = 'Τύπος υποδοχής';
    $Self->{Translation}->{'Software'} = 'Λογισμικό';
    $Self->{Translation}->{'Speakers'} = 'Ομιλητές';
    $Self->{Translation}->{'Standard SIM'} = '';
    $Self->{Translation}->{'Start IP Address'} = 'Διεύθυνση IP έναρξης';
    $Self->{Translation}->{'Storage'} = 'Αποθήκευση';
    $Self->{Translation}->{'Storage Partition'} = 'Διαμέρισμα αποθήκευσης';
    $Self->{Translation}->{'Subscription-based licenses'} = '';
    $Self->{Translation}->{'Subsidiary'} = 'Θυγατρική';
    $Self->{Translation}->{'Summary'} = 'Περίληψη';
    $Self->{Translation}->{'Thin Client'} = 'Λεπτός πελάτης';
    $Self->{Translation}->{'Threads'} = 'Νήματα';
    $Self->{Translation}->{'Thunderbolt'} = 'Thunderbolt';
    $Self->{Translation}->{'Total Graphics card RAM (GB)'} = 'Συνολική μνήμη RAM κάρτας γραφικών (GB)';
    $Self->{Translation}->{'Total RAM (GB)'} = 'Συνολική μνήμη RAM (GB)';
    $Self->{Translation}->{'Touchscreen Monitor'} = 'Οθόνη αφής';
    $Self->{Translation}->{'Tower'} = 'Πύργος';
    $Self->{Translation}->{'USB Hub'} = 'Διανομέας USB';
    $Self->{Translation}->{'USB-C'} = 'USB-C';
    $Self->{Translation}->{'VGA'} = 'VGA';
    $Self->{Translation}->{'VPN'} = 'VPN';
    $Self->{Translation}->{'VR Headset'} = 'Ακουστικά VR';
    $Self->{Translation}->{'Virtual Client'} = '';
    $Self->{Translation}->{'VirtualLink'} = 'VirtualLink';
    $Self->{Translation}->{'VoIP Phone'} = 'Τηλέφωνο VoIP';
    $Self->{Translation}->{'Volume licenses'} = '';
    $Self->{Translation}->{'Webcam'} = 'Webcam';


    push @{ $Self->{JavaScriptStrings} // [] }, (
    'Add all',
    'An error occurred during class import.',
    'An error occurred during communication.',
    'An item with this name is already present.',
    'Cancel',
    'Confirm',
    'Delete',
    'Dismiss',
    'Do you want to proceed?',
    'Importing classes/roles and their related fields',
    'No',
    'Note that also corresponding dynamic fields and GeneralCatalog classes will be created and there is no automatic removal.',
    'Ok',
    'Overview and Confirmation',
    'Please enter at least one search value or * to find anything.',
    'Search',
    'Settings',
    'Submit',
    'The following classes will be imported',
    'The following roles will be imported',
    'This item still contains sub items. Are you sure you want to remove this item including its sub items?',
    'Yes',
    );

}

1;
