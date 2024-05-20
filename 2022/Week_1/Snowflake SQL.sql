SELECT
    CASE 
        WHEN "Date of Birth" >= DATE_FROM_PARTS (2014, 09, 01) THEN '1'
        WHEN "Date of Birth" >= DATE_FROM_PARTS (2013, 09, 01) THEN '2'
        WHEN "Date of Birth" >= DATE_FROM_PARTS (2012, 09, 01) THEN '3'
        WHEN "Date of Birth" >= DATE_FROM_PARTS (2011, 09, 01) THEN '4'
        WHEN "Date of Birth" >= DATE_FROM_PARTS (2010, 09, 01) THEN '5'
        WHEN "Date of Birth" >= DATE_FROM_PARTS (2009, 09, 01) THEN '6'
    END AS ACADEMIC_YEAR,
    CONCAT ("pupil last name", ', ', "pupil first name") AS PUPIL_NAME,
    CONCAT ("pupil last name", ', ', IFF ("Parental Contact" = '1', "Parental Contact Name_1", "Parental Contact Name_2")) AS PARENTAL_CONTACT_FULL_NAME,
    CONCAT (IFF ("Parental Contact" = '1', "Parental Contact Name_1", "Parental Contact Name_2"), '.',"pupil last name", '@', "Preferred Contact Employer", '.com') AS PARENTAL_CONTACT_EMAIL_ADDRESS
FROM PD2022_WK01;