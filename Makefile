target:
	bash -e generate_ek_cert.sh
clean:
	sudo rm -fr _tpm* public* summaries* tpm2_ekc*
