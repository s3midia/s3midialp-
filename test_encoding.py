
s = "trÃƒÂ¡fego"
# s is what we see in the file (UTF-8 decoded string)
# emulate the bytes in the file
try:
    # First reversal
    b1 = s.encode('cp1252')
    s1 = b1.decode('utf-8')
    print(f"Pass 1: {s1}")
    
    # Second reversal
    b2 = s1.encode('cp1252')
    s2 = b2.decode('utf-8')
    print(f"Pass 2: {s2}")
except Exception as e:
    print(f"Error: {e}")
