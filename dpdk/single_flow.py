from trex_stl_lib.api import *

from addr import *

# Wild local MACs i.e Trex port0 and port1 macs
mac_localport0='ac:1f:6b:2d:1a:be'
mac_localport1='ac:1f:6b:2d:1a:bf'

class STLS1(object):

    def __init__ (self):
        self.fsize  =64; # the size of the packet 

    def create_stream (self, direction = 0):

        size = self.fsize - 4; # HW will add 4 bytes ethernet FCS
	if direction == 0:
          base_pkt =  Ether(dst=mac_telco0,src=mac_localport0)/IP(src="16.0.0.1",dst=ip_telco0)/UDP(dport=15,sport=1026)
	else:
          base_pkt =  Ether(dst=mac_telco1,src=mac_localport1)/IP(src="16.1.0.1",dst=ip_telco1)/UDP(dport=16,sport=1026)
        #pad = max(0, size - len(base_pkt)) * 'x'
        pad = (60 - len(base_pkt)) * 'x'

        return STLStream( 
            packet = 
                    STLPktBuilder(
                        pkt = base_pkt / pad
                    ),
             mode = STLTXCont())

    def create_stats_stream (self, rate_pps = 1000, pgid = 7, direction = 0):

        size = self.fsize - 4; # HW will add 4 bytes ethernet FCS
	if direction == 0:
          base_pkt =  Ether(dst=mac_telco0,src=mac_localport0)/IP(src="17.0.0.1",dst=ip_telco0)/UDP(dport=15,sport=1026)
	else:
          base_pkt =  Ether(dst=mac_telco1,src=mac_localport1)/IP(src="17.1.0.1",dst=ip_telco1)/UDP(dport=16,sport=1026)
        pad = max(0, size - len(base_pkt)) * 'x'

        return STLStream( 
            packet = 
                    STLPktBuilder(
                        pkt = base_pkt / pad
                    ),
             mode = STLTXCont(pps = rate_pps),
             flow_stats = STLFlowLatencyStats(pg_id = pgid))
             #flow_stats = STLFlowStats(pg_id = pgid))

    def get_streams (self, direction = 0, **kwargs):
        # create multiple streams, one stream per core... 
        s = []
        for i in xrange(8):
             s.append(self.create_stream(direction = direction))
	if direction == 0:
	    s.append(self.create_stats_stream(rate_pps=1000, pgid=10, direction = direction))
	else:
	    s.append(self.create_stats_stream(rate_pps=1000, pgid=11, direction = direction))
        
        return s 

# dynamic load - used for trex console or simulator
def register():
    return STLS1()




