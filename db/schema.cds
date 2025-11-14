using { Currency, managed, sap } from '@sap/cds/common';

namespace sap.capire.bookshop;

entity Books : managed {
  key ID   : Integer;
  title    : localized String(111)  @mandatory;
  descr    : localized String(1111);
  author   : Association to Authors @mandatory;
  genre    : Association to Genres;
  stock    : Integer;
  price    : Decimal;
  currency : Currency;
}

entity Authors : managed {
  key ID       : Integer;
  name         : String(111) @mandatory;
  dateOfBirth  : Date;
  dateOfDeath  : Date;
  placeOfBirth : String;
  placeOfDeath : String;
  books        : Association to many Books
                   on books.author = $self;
}

/** Hierarchically organized Code List for Genres */
entity Genres : sap.common.CodeList {
  key ID       : Integer;
      parent   : Association to Genres;
      children : Composition of many Genres
                   on children.parent = $self;
}


//new addeed

entity Hospital {
  key ID          : UUID;
  name            : String(100);
  location        : String(200);
  departments     : Association to many Department on departments.hospital = $self;
  patients        : Association to many Patient   on patients.hospital   = $self;
}

entity Department {
  key ID          : UUID;
  name            : String(100);
  hospital        : Association to Hospital;
  doctors         : Association to many Doctor on doctors.department = $self;
}

entity Doctor {
  key ID          : UUID;
  name            : String(100);
  specialization  : String(100);
  department      : Association to Department;
  appointments    : Association to many Appointment on appointments.doctor = $self;
}

entity Patient {
  key ID          : UUID;
  name            : String(100);
  age             : Integer;
  hospital        : Association to Hospital;
  appointments    : Association to many Appointment on appointments.patient = $self;
}

entity Appointment {
  key ID          : UUID;
  date            : Date;
  time            : Time;
  doctor          : Association to Doctor;
  patient         : Association to Patient;
}

entity Submissions {
  key ID: UUID;
  HospitalID: UUID;
  Action: String;
}
