using HospitalService as service from '../../srv/hospital-service';

annotate service.Hospitals with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Name',
                Value : name
            },
            {
                $Type : 'UI.DataField',
                Label : 'Location',
                Value : location
            }
        ]
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneralInfo',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'DepartmentsFacet',
            Label : 'Departments',
            Target : 'departments/@UI.LineItem'
        }
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Name',
            Value : name
        },
        {
            $Type : 'UI.DataField',
            Label : 'Location',
            Value : location
        }
    ]
);

annotate service.Departments with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Department Name',
                Value : name
            },
            {
                $Type : 'UI.DataField',
                Label : 'Hospital ID',
                Value : hospital_ID
            }
        ]
    },
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Department Name',
            Value : name
        },
        {
            $Type : 'UI.DataField',
            Label : 'Hospital ID',
            Value : hospital_ID
        }
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'DeptGeneral',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup'
        }
    ]
);