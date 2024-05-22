def add_comma(num):
    # Convert number to string
    num_str = str(num)
    if len(num_str) <= 3:
        return num_str
    else:
        if len(num_str) <= 5:
            return num_str[:len(num_str)-3] + ',' + num_str[len(num_str)-3:]
        else:
            num=''
            reversed_num = num_str[::-1]
            num=reversed_num[0:3]+","
            for i in range(3,len(reversed_num),2):
                if(i+2>=len(reversed_num)):
                    num= num+reversed_num[i:]
                else:
                    num= num+reversed_num[i:i+2]+","
            return num[::-1]

            
    # Split integer and fractional parts if there is a decimal point
#     if '.' in num_str:
#         integer_part, fractional_part = num_str.split('.')
#     else:
#         integer_part, fractional_part = num_str, ''

#     # Reverse the integer part for easier processing
#     reversed_int = integer_part[::-1]

#     # Process the reversed integer part to insert commas
#     grouped = []
#     for i in range(0, len(reversed_int), 2):
#         if i == 0:
#             grouped.append(reversed_int[i:i+3])
#         else:
#             grouped.append(reversed_int[i:i+2])

#     # Join groups with commas and reverse back to normal order
#     formatted_int = ','.join(grouped)[::-1]

#     # Combine integer and fractional parts
#     if fractional_part:
#         return f'{formatted_int}.{fractional_part}'
#     else:
#         return formatted_int

# # Example usage
# total1 = 895329
# total2 = 1417
# total3 = 10000000
# total4 = 100

# print(add_comma(total1))  # Output: '8,95,329'
# print(add_comma(total2))  # Output: '1,417'
# print(add_comma(total3))  # Output: '1,00,00,000'
# print(add_comma(total4))  # Output: '100'
