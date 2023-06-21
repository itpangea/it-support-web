document.querySelector('form').addEventListener('submit', async (event) => {
    event.preventDefault();
  
    const formData = new FormData(event.target);
    const data = {
      name: formData.get('name'),
      email: formData.get('email'),
      issue: formData.get('issue')
    };
  
    try {
      const response = await fetch('/api/support', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
      });
  
      if (response.ok) {
        alert('Support request submitted successfully!');
      } else {
        alert('Failed to submit support request.');
      }
    } catch (error) {
      alert('An error occurred while submitting the support request.');
    }
  });  