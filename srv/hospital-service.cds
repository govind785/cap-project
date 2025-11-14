using {sap.capire.bookshop as my} from '../db/schema';

service HospitalService @(path: '/odata/v4/hospital') {
  entity Hospitals    as projection on my.Hospital;
  entity Departments  as projection on my.Department;
  entity Doctors      as projection on my.Doctor;
  entity Patients     as projection on my.Patient;
  entity Appointments as projection on my.Appointment;
    entity Submissions as projection on my.Submissions;

}