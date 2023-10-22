trigger ValidarCPFTrigger on Account (before insert, before update) {
  	public class CpfException extends Exception {} 
    String message;
    
    if(Trigger.isUpdate || Trigger.isInsert) {
        for(Account acc : Trigger.new) {
            String cpf = acc.Cpf__c;
            
            if(cpf != null) {
                try{
                    validateIfCpfHasOnlyNumbers(cpf);
                   	validateIfCpfHasOnlyElevenNumbers(acc, cpf);
                    validateIfCpfHasSequenceOfNumbers(acc, cpf);
                    validateIfCpfHasSequenceOfEgualNumbers(acc, cpf);
                    validateIfCpfIsValid(acc, cpf);
                } catch(Exception e) {
                    acc.addError(message);
                }
                
                if(message != null)
                    acc.addError(message);
            }
        }
    }
    
    public static void validateIfCpfHasOnlyNumbers(String cpf) {
       Pattern pattern = Pattern.compile('^[0-9]+$');
       Matcher matcher = pattern.matcher(cpf);
       
        if(matcher.matches() == false) {
       		message = 'CPF deve conter apenas caracteres numéricos';
            throw new CpfException(); 
        }
    }
    
   	public static void validateIfCpfHasOnlyElevenNumbers(Account acc, String cpf) {
        if(cpf.length() != 11) {
       		message = 'CPF deve conter 11 dígitos';
        	throw new CpfException(); 
        }
    }
    
    public static List<Integer> convertCpfAsInteger(String cpf) {
        List<Integer> cpfSplitAsIntegers = new List<Integer>();
        
        for(String cpfString : cpf.split('')) {
            cpfSplitAsIntegers.add(Integer.valueOf(cpfString));
        }
        
        return cpfSplitAsIntegers;
    }
    
    public static void validateIfCpfHasSequenceOfNumbers(Account acc, String cpf) {
        List<Integer> cpfSplitAsIntegers = convertCpfAsInteger(cpf);
        Integer count = 0;

        for(Integer i = cpfSplitAsIntegers[0]; i < cpfSplitAsIntegers.size(); i++) {
            if(cpfSplitAsIntegers[i] == i) {
             	count++;
            }
        }
         
        if(count == 10) {
           	message = 'CPF com números sequenciais ' + cpf + ' não é válido';
            throw new CpfException(); 
        }
    }
    
    public static boolean compareNumbersOfCep(String cpf) {
        List<Integer> cpfSplitAsIntegers = convertCpfAsInteger(cpf);
        
        for(Integer numberOfCpf : cpfSplitAsIntegers) {
            for(Integer numberTwoOfCpf : cpfSplitAsIntegers) {
                if(numberOfCpf != numberTwoOfCpf) {
                    return false;
                }
        	}
        }
        
        return true;
    }
        
    public static void validateIfCpfHasSequenceOfEgualNumbers(Account acc, String cpf) {
        boolean isEqualNumbers = compareNumbersOfCep(cpf);
        
        if(isEqualNumbers) {
            message = 'CPF com sequencia de número único não é válido'; 
            throw new CpfException(); 
        }
    }
    
    public static Integer calculateVerifyingDigit(List<Integer> cpfSplitAsIntegers, Integer multiply, Integer positionCpfNumber) {
        try {
            Integer count = 0;
            Integer sumNumbersOfCpf = 0;
            Integer restOfDivision;
        
            for(Integer numberOfCpf : cpfSplitAsIntegers) {
                if(count != positionCpfNumber && count < positionCpfNumber) {
                    sumNumbersOfCpf+= numberOfCpf * multiply;
                    multiply--;
                } 
                count++;
            }
            
            restOfDivision = Math.mod(sumNumbersOfCpf, 11);
            return restOfDivision;
        } catch (Exception e) {
            message = 'CPF não é consistente'; 
            return null;
        }
    }
    
    public void compareVerifyingDigits(Integer restOfDivision, List<Integer> cpfSplitAsIntegers, Integer positionCpfNumber, Account acc) {
        try {
            if(restOfDivision == 0 || restOfDivision == 1) {
                if(cpfSplitAsIntegers[positionCpfNumber] != 0) {
                    message = 'CPF não é consistente';
                    throw new CpfException();
                } 
        	} else {
            	Integer verifyingDigit = 11 - restOfDivision;
            
                if(verifyingDigit != cpfSplitAsIntegers[positionCpfNumber]) {
                    message = 'CPF não é consistente ';
                    throw new CpfException();
                }
        	}
        } catch (Exception e) {
            message = 'CPF não é consistente';
        }
    }
        
    public static void validateIfCpfIsValid(Account acc, String cpf) {
        try {
            List<Integer> cpfSplitAsIntegers = convertCpfAsInteger(cpf);
            Integer multiply = 10;
            Integer positionCpfNumber = 9;
            
            Integer restOfFirstVerifyingDigit = calculateVerifyingDigit(cpfSplitAsIntegers, multiply, positionCpfNumber);        
            compareVerifyingDigits(restOfFirstVerifyingDigit, cpfSplitAsIntegers, positionCpfNumber, acc);
            
            multiply = 11;
            positionCpfNumber = 10;
            
            Integer restOfSecondVerifyingDigit = calculateVerifyingDigit(cpfSplitAsIntegers, multiply, positionCpfNumber);
            compareVerifyingDigits(restOfSecondVerifyingDigit, cpfSplitAsIntegers, positionCpfNumber, acc);
        } catch (Exception e) {
            message = 'CPF não é consistente';
        }
    }
}