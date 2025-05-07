// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultiLevelSecurity {

    // Enum to define roles and their associated access levels
    enum Role { Patient, Doctor, Nurse }
    enum SecurityLevel { Confidential, Secret, TopSecret }
    
    // Struct for a Subject (User)
    struct Subject {
        address userAddress; // user's address
        Role role;           // user role (patient, doctor, etc.)
        SecurityLevel securityLevel; // user's security level
        bool isAuthenticated; // if the user is authenticated
        string privateKey;    // Private key (For simulation, actual private key should not be stored on-chain)
    }
    
    // Mapping of Subjects by their address
    mapping(address => Subject) public subjects;
    
    // Mapping of Resources (e.g., documents, data)
    mapping(string => SecurityLevel) public resources;
    
    // Access control mapping for Subjects' access to Resources
    mapping(address => mapping(string => bool)) public accessControl;
    
    // Events for logging purpose
    event AccessGranted(address indexed subject, string resource);
    event AccessDenied(address indexed subject, string resource);
    
    // Modifier to check authentication
    modifier onlyAuthenticated(address userAddress) {
        require(subjects[userAddress].isAuthenticated, "User is not authenticated.");
        _;
    }

    // Constructor to set initial subjects and resources
    constructor() {
        // Example subjects
        subjects[msg.sender] = Subject({
            userAddress: msg.sender,
            role: Role.Doctor,
            securityLevel: SecurityLevel.TopSecret,
            isAuthenticated: true,
            privateKey: "fake-private-key-for-doctor"
        });
        
        // Example resources
        resources["PatientRecord"] = SecurityLevel.TopSecret;
        resources["LabTest"] = SecurityLevel.Secret;
        resources["BasicInfo"] = SecurityLevel.Confidential;
    }

    function addPatient(address patientAddress) public {
    require(subjects[msg.sender].role == Role.Doctor, "Only a Doctor can add a Patient.");
    
    // Add the Patient with default Confidential security level
    subjects[patientAddress] = Subject({
        userAddress: patientAddress,
        role: Role.Patient,
        securityLevel: SecurityLevel.Confidential,
        isAuthenticated: false, 
        privateKey: "private-key-for-patient" 
        });
    }
 
    // Add Nurse Function
    function addNurse(address nurseAddress) public {
        require(subjects[msg.sender].role == Role.Doctor, "Only a Doctor can add a Nurse.");
    
        // Add the Nurse with Secret security level
        subjects[nurseAddress] = Subject({
        userAddress: nurseAddress,
        role: Role.Nurse,
        securityLevel: SecurityLevel.Secret,
        isAuthenticated: false, 
        privateKey: "private-key-for-nurse" 
        });
    }



    // Procedure 1: Credential verification
    function verifyCredentials(address userAddress, string memory providedPrivateKey) public {
        // Verifying subject and private key (simulation, actual keys shouldn't be stored on-chain)
        require(keccak256(abi.encodePacked(subjects[userAddress].privateKey)) == keccak256(abi.encodePacked(providedPrivateKey)), "Invalid private key.");
        
        subjects[userAddress].isAuthenticated = true;
    }
    
    // Procedure 2: Multi-level security using LBAC
    function checkAccess(address userAddress, string memory resource) public view returns (bool) {
        // Retrieve the subject's role and security level
        Subject memory user = subjects[userAddress];
        SecurityLevel resourceLevel = resources[resource];
        
        // Access is granted based on the security levels
        if (user.securityLevel >= resourceLevel) {
            return true;
        }
        return false;
    }

    // Grant access to a resource based on the security levels
    function grantAccess(address userAddress, string memory resource) public onlyAuthenticated(userAddress) {

        

        // Check if the user has permission to access the resource
        bool hasAccess = checkAccess(userAddress, resource);
        
        if (hasAccess) {
            accessControl[userAddress][resource] = true;
            emit AccessGranted(userAddress, resource);
        } else {
            emit AccessDenied(userAddress, resource);
        }
    }

    // Block creation via smart contract (simulating a blockchain transaction)
    function createBlockTransaction(address userAddress, string memory resource) public onlyAuthenticated(userAddress) {
        // Only create a block if the subject has access
        require(accessControl[userAddress][resource], "Access not granted.");
        
        // Simulating blockchain transaction creation
        string memory transactionDetails = string(abi.encodePacked("Access to ", resource, " granted to ", toString(userAddress)));
        
        // Here, instead of actually interacting with a blockchain network, we just emit an event to simulate the transaction.
        emit TransactionCreated(transactionDetails);
    }
    
    // Utility function to convert address to string for logging purposes
    function toString(address _address) public pure returns (string memory) {
        return string(abi.encodePacked(_address));
    }
    
    // Event for transaction creation (simulating blockchain interaction)
    event TransactionCreated(string transactionDetails);
}
