{-# LANGUAGE GADTs #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}

module Syntax where

import Deco (Deco, Switch)
 
-- | Names of companies, departments, and employees
type Name = String

-- | Addresses as strings
type Address = String

-- | Salaries as floats
type Salary = Float

-- | A company consists of name and top-level departments
data Company (s:: Switch) = Company { cName :: Name, depts :: [Department s] }
 deriving (Eq, Show)

-- | A department consists of name, manager, sub-departments, and employees
data Department (s :: Switch ) = Department {  dName :: Name, manager :: Manager s, subDepts :: [Department s], emps :: [Employee s] }
 deriving (Eq, Show)

-- | An employee consists of name, address, and salary
data Employee (s :: Switch) = Employee { eName :: Name, address :: Address, salary :: Salary, deco :: Deco s Integer }
 deriving (Eq, Show)

-- | Managers as employees
type Manager = Employee


 
