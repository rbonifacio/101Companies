{-# LANGUAGE DataKinds #-}
module Sample where

import Deco
import Syntax

sampleCompanyU :: Company 'Unchecked
sampleCompanyU =
  Company
    "Acme Corporation"
    [
      Department "Research"
        (Employee "Craig" "Redmond" 123456 U)
        []
        [
          (Employee "Erik" "Utrecht" 12345 U),
          (Employee "Ralf" "Koblenz" 1234 U)
        ],
      Department "Development"
        (Employee "Ray" "Redmond" 234567 U)
        [
          Department "Dev1"
            (Employee "Klaus" "Boston" 23456 U)
            [
              Department "Dev1.1"
                (Employee "Karl" "Riga" 2345 U)
                []
                [(Employee "Joe" "Wifi City" 2344 U)]
            ]
            []
        ]
        []
    ]


sampleCompanyC :: Company 'Checked
sampleCompanyC =
  Company
    "Acme Corporation"
    [
      Department "Research"
        (Employee "Craig" "Redmond" 123456 (T 1))
        []
        [
          (Employee "Erik" "Utrecht" 12345 (T 2)),
          (Employee "Ralf" "Koblenz" 1234 (T 3))
        ],
      Department "Development"
        (Employee "Ray" "Redmond" 234567 (T 4))
        [
          Department "Dev1"
            (Employee "Klaus" "Boston" 23456 (T 5))
            [
              Department "Dev1.1"
                (Employee "Karl" "Riga" 2345 (T 6))
                []
                [(Employee "Joe" "Wifi City" 2344 (T 7))]
            ]
            []
        ]
        []
    ]
