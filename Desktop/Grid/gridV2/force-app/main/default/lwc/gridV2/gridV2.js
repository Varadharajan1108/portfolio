import { LightningElement, wire, track, } from 'lwc';
import retrieveData from '@salesforce/apex/DataController.retrieveData';
import retrieveLWCComponents from '@salesforce/apex/RetrieveLWCComponents.retrieveLWCComponents';
import retrieveApexTriggers from '@salesforce/apex/RetrieveApexTriggers.retrieveApexTriggers';
import retrieveAuraComponents from '@salesforce/apex/AuraComponentRetrieval.retrieveAuraComponents';
import retrieveApexPages from '@salesforce/apex/ApexPageController.retrieveApexPages';
import retrieveAssignmentRules from '@salesforce/apex/RetrieveAssignmentRules.retrieveAssignmentRules';
import retrieveConnectedApplications from '@salesforce/apex/ConnectedAppRetrieval.retrieveConnectedApplications';
import retrieveDocuments from '@salesforce/apex/RetrieveDocuments.retrieveDocuments';
import retrieveProfiles from '@salesforce/apex/RetrieveProfiles.retrieveProfiles';
import retrievePermissionSets from '@salesforce/apex/RetrievePermissionSets.retrievePermissionSets';
import retrieveEmailNotifications from '@salesforce/apex/RetrieveEmailNotifications.retrieveEmailNotifications';
import retrieveApexTestSuites from '@salesforce/apex/RetrieveApexTestSuites.retrieveApexTestSuites';
import retrieveAppMenuItem from '@salesforce/apex/RetrieveAppMenuItems.retrieveAppMenuItem';
import RetrievePermissionSetGroups from '@salesforce/apex/RetrievePermissionSetGroups.RetrievePermissionSetGroups';
import retrieveCustomApplications from '@salesforce/apex/RetrieveCustomApplications.retrieveCustomApplications';
import retrieveCustomFields from '@salesforce/apex/RetrieveCustomFields.retrieveCustomFields';
import retrieveCustomTabs from '@salesforce/apex/RetrieveCustomTabs.retrieveCustomTabs';
import retrieveDashboardData from '@salesforce/apex/RetrieveDashboardData.retrieveDashboardData';
import retrieveDuplicateRules from '@salesforce/apex/RetriveDuplicatRules.retrieveDuplicateRules';
import retrieveApprovalProcesses from '@salesforce/apex/RetrieveApprovalProcesses.retrieveApprovalProcesses';
import retrieveCustomObjects from '@salesforce/apex/RetrieveCustomObject.retrieveCustomObjects';
import retrieveStandardObjects from '@salesforce/apex/RetrieveStandardObjects.retrieveStandardObjects';


export default class MetadataTable extends LightningElement {
   // @track selectedType = 'ALL';
    @track filteredData=[];
    data = [];
   

    columns = [
        { label: 'Id', fieldName: 'Id', type: 'text' },
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Type', fieldName: 'Type', type: 'text' },
        { label: 'Created Date', fieldName: 'CreatedDate', type: 'date' },
        { label: 'Last Modified Date', fieldName: 'LastModifiedDate', type: 'date' },
        { label: 'Last Modified By ID', fieldName: 'LastModifiedById', type: 'text' },
    ];

    Type = [
        { label: 'ALL', value: 'ALL' },
        { label: 'Apex Class', value: 'Apex Class' },
        { label: 'Apex Trigger', value: 'Apex Trigger' },
        { label: 'Lightning Web Component', value: 'Lightning Web Component' },
        { label: 'Aura Component', value: 'Aura Component' },
        { label: 'Apex Page', value: 'Apex Page' },
        {label: 'Custom Object', value: 'Custom Object'},
        {label: 'Standard Object', value: 'Standard Object'},
        { label: 'Apex Email Notifications', value: 'Apex Email Notifications' },
        { label: 'Apex Test Suite', value: 'Apex Test Suite' },
        { label: 'App Menu Item', value: 'App Menu Item' },
        { label: 'Approval Process', value: 'Approval Process' },
        { label: 'Assignment Rule', value: 'Assignment Rule' },
        { label: 'Connected Application', value: 'Connected Application' },
        { label: 'Custom Application', value: 'Custom Application' },
        { label: 'Custom Field', value: 'Custom Field' },
        { label: 'Custom Metadata', value: 'Custom Metadata' },
        { label: 'Custom Tabs', value: 'Custom Tab' },
        { label: 'Dashboard', value: 'Dashboard' },
        { label: 'Document', value: 'Document' },
        { label: 'Duplicate Rule', value: 'Duplicate Rule' },
        { label: 'Profile', value: 'Profile' },
        { label: 'Permission Set', value: 'Permission Set' },
        { label: 'Permission Set Group', value: 'Permission Set Group' }
    ];
    
    initialRecords = [];




    // WIRE METHODS
    
    @wire(retrieveData)
    wiredApexClass({ error, data }) {
        if (data) {
            // Map the fetched data to include Type and other properties
            const apexClassData = data.map((record) => ({
                ...record,
                Type: 'Apex Class',
                selected: false,
            }));
            this.data = [...this.data, ...apexClassData];
    
            // Push apexClassData into initialRecords
            this.initialRecords.push(...apexClassData);
    
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = [];
        }
    }
    
    @wire(retrieveLWCComponents)
    wiredLWCComponents({ error, data }) {
        if (data) {
            // Map the fetched data to include Type and other properties
            const lwcComponentData = data.map((record) => ({
                ...record,
                Type: 'Lightning Web Component',
                selected: false,
                Name: record.DeveloperName,
            }));
            this.data = [...this.data, ...lwcComponentData];
    
            // Push lwcComponentData into initialRecords
            this.initialRecords.push(...lwcComponentData);
    
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = [];
        }
    }
    
    @wire(retrieveApexTriggers)
    wiredApexTriggers({ error, data }) {
        if (data) {
            // Map the fetched data to include Type and other properties
            const apexTriggerData = data.map((record) => ({
                ...record,
                Type: 'Apex Trigger',
                selected: true,
            }));
            this.data = [...this.data, ...apexTriggerData];
    
            // Push apexTriggerData into initialRecords
            this.initialRecords.push(...apexTriggerData);
    
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = [];
        }
    }
    
    @wire(retrieveAuraComponents)
    wiredAuraComponents({ error, data }) {
        if (data) {
            // Map the fetched data to include Type and other properties
            const auraComponentData = data.map((record) => ({
                ...record,
                Type: 'Aura Component',
                selected: false,
            }));
            this.data = [...this.data, ...auraComponentData];
    
            // Push auraComponentData into initialRecords
            this.initialRecords.push(...auraComponentData);
    
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = [];
        }
    }
    

    @wire(retrieveApexPages)
    wiredApexPages({ error, data }) {
        if (data) {
            // Map the fetched data to include Type and other properties
            const apexPageData = data.map((record) => ({
                ...record,
                Type: 'Apex Page',
                selected: false,
            }));
            this.data = [...this.data, ...apexPageData];
            // Push apexPageData into initialRecords
            this.initialRecords.push(...apexPageData);
            
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = [];
        }
    }
    
    @wire(retrieveAssignmentRules)
    wiredAssignmentRules({ error, data }) {
        if (data) {
            // Map the fetched data to include Type and other properties
            const assignmentRuleData = data.map((record) => ({
                ...record,
                Type: 'Assignment Rule',
                selected: false,
            }));
            this.data = [...this.data, ...assignmentRuleData];
            
            // Push assignmentRuleData into initialRecords
            this.initialRecords.push(...assignmentRuleData);
            
            this.error = undefined;
        } else if (error) {
           this.error=error;
           this.data=[];
        }
    }
    @wire(retrieveConnectedApplications)
    wiredConnectedApplications({ error, data }) {
        if (data) {
            // Map the fetched data to include Type and other properties
            const connectedAppData = data.map((record) => ({
                ...record,
                Type: 'Connected Application',
                selected: false,
            }));
    
            // Set the data property with the retrieved data
            this.data = [...this.data,...connectedAppData];
            this.initialRecords.push(...connectedAppData);    
            this.error = undefined;
        } else if (error) {
            // Handle any errors
            this.error = error;
            this.data = [];
        }
    }
    @wire(retrieveDocuments)
    wiredDocuments({ error, data }) {
        if (data) {
            // Map the fetched data to include Type and other properties
            const documentData = data.map((record) => ({
                ...record,
                Type: 'Document',
                selected: false,
                Name:record.DeveloperName,
            }));
                
            // Set the data property with the retrieved data
            this.data = [...this.data, ...documentData];
            this.initialRecords.push(...documentData);

            this.error = undefined;
        } else if (error) {
            // Handle any errors
            this.error = error;
            this.data = [];
        }
    }

    @wire(retrieveProfiles)
    wiredProfiles({ error, data }) {
        if (data) {
            // Map the fetched data to include Type and other properties
            const profileData = data.map((record) => ({
                ...record,
                Type: 'Profile',
                selected: false,
            }));

            // Set the data property with the retrieved data
            this.data = [...this.data, ...profileData];
            this.initialRecords.push(...profileData);

            this.error = undefined;
        } else if (error) {
            // Handle any errors
            this.error = error;
            this.data = [];
        }
    }

    @wire(retrievePermissionSets)
    wiredPermissionSets({ error, data }) {
        if (data) {
            // Map the fetched data to include Type and other properties
            const permissionSetData = data.map((record) => ({
                ...record,
                Type: 'Permission Set',
                selected: false,
            }));

            // Set the data property with the retrieved data
            this.data = [...this.data, ...permissionSetData];
            this.initialRecords.push(...permissionSetData);

            this.error = undefined;
        } else if (error) {
            // Handle any errors
            this.error = error;
            this.data = [];
        }
    }

    @wire(retrieveEmailNotifications)
wiredEmailNotifications({ error, data }) {
    if (data) {
        // Map the fetched data to include Type and other properties
        const emailNotificationData = data.map((record) => ({
            ...record,
            Type: 'Email Notification', // Adjust the Type as needed
            selected: false,
            UserId: record.DeveloperName,

        }));
                       

        // Set the data property with the retrieved data
        this.data = [...this.data, ...emailNotificationData];
        this.initialRecords.push(...emailNotificationData);

        this.error = undefined;
    } else if (error) {
        // Handle any errors
        this.error = error;
        this.data = [];
    }
}

@wire(retrieveApexTestSuites)
wiredTestSuites({ error, data }) {
    if (data) {
        // Map the fetched data to include Type and other properties
        const testSuiteData = data.map((record) => ({
            ...record,
            Type: 'Apex Test Suite',
            selected: false,
            Name: record.TestSuiteName,
        }));

        // Set the data property with the retrieved data
        this.data = [...this.data, ...testSuiteData];
        this.initialRecords.push(...testSuiteData);

        this.error = undefined;
    } else if (error) {
        this.error = error;
        this.data = [];
    }
}

@wire(retrieveAppMenuItem)
    wiredAppMenuItems({ error, data }) {
        if (data) {
            // Map the fetched data to include Type and other properties
            const appMenuData = data.map((record) => ({
                ...record,
                Type: 'App Menu Item',
                selected: false,
            }));
            this.data = [...this.data, ...appMenuData];
    
            // Push appMenuData into initialRecords if needed
            this.initialRecords.push(...appMenuData);
    
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = [];
        }
    }

    @wire(RetrievePermissionSetGroups)
    wiredPermissionSetGroup({ error, data }) {
        if (data) {
            // Map the fetched data to include Type and other properties
            const permissionSetGroupData = data.map((record) => ({
                ...record,
                Type: 'Permission Set Group',
                selected: false,
                Name:record.DeveloperName,
            }));
            this.data = [...this.data, ...permissionSetGroupData];
    
            // Push permissionSetGroupData into initialRecords if needed
            this.initialRecords.push(...permissionSetGroupData);
    
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = [];
        }
    }
    @wire(retrieveCustomApplications)
    wiredCustomApplications({ error, data }) {
        if (data) {
            // Map the fetched data to include Type and other properties
            const customApplicationsData = data.map((record) => ({
                ...record,
                Type: 'Custom Application',
                selected: false,
                Name:record.DeveloperName,
            }));

            // Set the data property with the retrieved data
            this.data = [...this.data, ...customApplicationsData];
            this.initialRecords.push(...customApplicationsData);

            this.error = undefined;
        } else if (error) {
            // Handle any errors
            this.error = error;
            this.data = [];
        }
    }
    @wire(retrieveCustomFields)
wiredCustomFields({ error, data }) {
    if (data) {
        // Map the fetched data to include Type and other properties
        const customFieldData = data.map((record) => ({
            ...record,
            Type: 'Custom Field',
            selected: false,
            Name:record.DeveloperName,
        }));

        // Set the data property with the retrieved data
        this.data = [...this.data, ...customFieldData];
        this.initialRecords.push(...customFieldData);

        this.error = undefined;
    } else if (error) {
        this.error = error;
        this.data = [];
    }
}

@wire(retrieveCustomTabs)
wiredCustomTabs({ error, data }) {
    if (data) {
        // Map the fetched data to include Type and other properties
        const customTabsData = data.map((record) => ({
            ...record,
            Type: 'Custom Tab',
            selected: false,
            Name:record.DeveloperName,
            
        }));
        this.data = [...this.data, ...customTabsData];

        // Push apexTriggerData into initialRecords
        this.initialRecords.push(...customTabsData);

        this.error = undefined;
    } else if (error) {
        this.error = error;
        this.data = [];
    }
}
@wire(retrieveDashboardData)
wiredDashboardData({ error, data }) {
    if (data) {
        // Map the fetched data to include Type and other properties
        const DashboardData = data.map((record) => ({
            ...record,
            Type: 'Permission Set',
            selected: false,
        }));

        // Set the data property with the retrieved data
        this.data = [...this.data, ...DashboardData];
        this.initialRecords.push(...DashboardData);

        this.error = undefined;
    } else if (error) {
        // Handle any errors
        this.error = error;
        this.data = [];
    }
}
@wire (retrieveDuplicateRules)
wiredduplicateRules({error,data}){
    if(data){
        const duplicateRulesData=data.map((record)=>({
            ...record,
            Type:'Duplicate Rule',
            selected:false,
            Name:record.DeveloperName
        }));
        this.data=[...this.data,...duplicateRulesData];
        this.initialRecords.push(...duplicateRulesData);
        this.error=undefined;
    }else if(error){
        this.error=error;
        this.data=[];
    }
}

@wire (retrieveApprovalProcesses)
wiredapprovalProcesses({error,data}){
    if(data){
        const approvalProcessesData=data.map((record)=>({
            ...record,
            Type:'Approval Process',
            selected:false,
        }));
        this.data=[...this.data,...approvalProcessesData];
        this.initialRecords.push(...approvalProcessesData);
        this.error=undefined;
    }else if(error){
        this.error=error;
        this.data=[];
    }
}
@wire(retrieveCustomObjects)
    wiredCustomObjects({ error, data }) {
        if (data) {
            // Map the fetched data to include Type and other properties
            const customObjectData = data.map((record) => ({
                ...record,
                Type: 'Custom Object',
                selected: false,
                Name: record.DeveloperName,
            }));
            this.data = [...this.data, ...customObjectData];
    
            // Push lwcComponentData into initialRecords
            this.initialRecords.push(...customObjectData);
    
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = [];
        }
    }
    
    @wire(retrieveStandardObjects)
    wiredStandardObjects({ error, data }) {
        if (data) {
            // Map the fetched data to include Type and other properties
            const standardObjectData = data.map((record) => ({
                ...record,
                Type: 'Standard Object',
                selected: false,
                Name: record.DeveloperName,
            }));
            this.data = [...this.data, ...standardObjectData];
    
            // Push lwcComponentData into initialRecords
            this.initialRecords.push(...standardObjectData);
    
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = [];
        }
    }
    




//Search function, to search through all the records 
handleSearch(event) {
    const searchKey = event.target.value.toLowerCase();
console.log('Initial Data',this.initialRecords);
    if (searchKey) {
        // Filter data based on the search key
        this.data = this.initialRecords.filter(item => {
            const valuesArray = Object.values(item);

            for (const val of valuesArray) {
                const strVal = String(val);

                if (strVal.toLowerCase().includes(searchKey)) {
                    return true; // Include the item if the search key is found
                }
            }

            return false;
        });
    } else {
        // If the search key is empty, reset the data to its initial state
       this.data = [...this.initialRecords];
        console.log('Last Result',this.data);
    }
}


handleTypeChange(event) {
    var selectedType = event.target.value;
    console.log('Event',event);
    console.log('Selected Metadata Type', selectedType);
    if (selectedType === 'ALL') {
        this.data = [...this.initialRecords];
        console.log('Data after selecting ALL', this.data);
    } else {
        // Filter data based on the selected metadata type
        console.log('Initial Value', this.initialRecords);
        console.log('Data Value', this.data);
        
        this.data = this.initialRecords.filter(item => {
            console.log('Item',item.Type,' Selected ',selectedType);
             if(item.Type === selectedType){
                return true;
             }
             return false;
        });
        
      //  this.data =[...filteredData] ;

        console.log('Data after filtering by a specific Metadata Type');
    }
}




    // Simple selection of checkboxes
    handleCheckboxChange(event) {
        const fieldName = event.target.getAttribute('data-fieldname'); // Get the field name from the checkbox attribute
        const isChecked = event.target.checked;
    
        // Find the corresponding record in the data array
        const selectedRecord = this.data.find(record => record.Id === fieldName);
    
        if (selectedRecord) {
            // Update the selected property of the record
            selectedRecord.selected = isChecked;
    
            // Update the selectedIds array based on checkbox selection
            if (isChecked) {
                this.selectedIds.push(fieldName);
            } else {
                const index = this.selectedIds.indexOf(fieldName);
                if (index !== -1) {
                    this.selectedIds.splice(index, 1);
                }
            }
        }
    }
  

    //To select all the checkboxes
    handleSelectAll(event) {
        this.selectAll = event.target.checked;

        // Update the selectedIds array based on "Select All" checkbox
        if (this.selectAll) {
            this.selectedIds = this.data.map((record) => record.Id);
        } else {
            this.selectedIds = [];
        }
    }
   
    
    
}